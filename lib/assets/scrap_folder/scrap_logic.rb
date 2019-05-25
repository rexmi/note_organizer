require 'nokogiri'
require 'open-uri'
require 'date'
require 'set'
# require 'selenium-webdriver'


module Assets::Scrap_Folder::Scrap_Logic
  # @@title = Set[]
  # @@pid_history = Set[] # get this from csv
  # @@pid_ignore_list = []  # loaded from csv

  def generate_doc(url)
    html = open(url)
    @html = Nokogiri::HTML(html)
  end

  # def generate_dummy_doc(text)
  #   @html= Nokogiri::HTML(text)
  # end

  def random_sleep(extra=0)
    t = rand(3..8)
    puts "sleep for #{t + extra} seconds"
    sleep(t + extra)
  end


  def pid_exist?(pid)
    ScrapResult.pluck(:pid).include? pid
  end

  def title_exist?(title)
    ScrapResult.pluck(:title).include? title
  end

  # def get_pid()
  #   result = []
  #   t = @html.css('.result-row')
  #   t.each do |row|
  #     result << row['data-pid']
  #     @@pid_history << row['data-pid']
  #   end
  #   result  # an array of pid
  # end

  def get_all_rows(html)
    html.css(".result-row")
  end

  def get_pid(noko_obj)
    noko_obj["data-pid"]
  end

  def get_datetime(noko_obj)
    noko_obj.at_css("time")["datetime"]
  end

  def get_link_n_title(noko_obj)
    link = noko_obj.css("a.result-title")[0]["href"]
    title = noko_obj.css("a.result-title")[0].content
    return link, title
  end


  # def get_date(pid)
  #   temp = @html.css('.result-row[data-pid="' + pid.to_s + '"]')
  #   temp.css('.result-date[datetime]')[0]['datetime']
  # end

  # get title from inside each gig_post
  # def get_title(pid)
  #   temp = pid_selector pid
  #   temp.css('.result-title').text
  # end

  # get link according to pid from gig_page
  # def get_link(pid)
  #   temp = @html.css('.result-row[data-pid="' + pid.to_s + '"]')
  #   temp.css('a').first['href']
  # end

  def pid_selector(pid)
    @html.css('.result-row[data-pid="' + pid.to_s + '"]')
  end

  # check now vs datetime_obj, if within length return true
  # return false if difference > length(days)
  def date_validator(length, datetime_obj)
    dt = DateTime.parse(datetime_obj)
    if DateTime.now().mjd - dt.mjd > length
      return false
    else
      return true
    end
  end

  # this is for scraping reply, can't do on craigslist
  # def get_post_content(url)
    # driver = Selenium::WebDriver.for :chrome
    # wait = Selenium::WebDriver::Wait.new(timeout: 10)
    # driver.navigate.to url
    # begin
    #   element = driver.find_element(:class, 'reply_button')
    #   element.click()
    #   e2 = wait.until { driver.find_element(:class, 'anonemail') }
    #   reply_email = e2.text
    # rescue Selenium::WebDriver::Error::NoSuchElementError
    #   p 'no reply email'
    #   reply_email = 'none'
    # end
  #   content = driver.find_element(:id, 'postingbody').text
  #   content.sub!("\n        \n            QR Code Link to This Post\n            \n        \n", '')
  #   # reply_email = e2.text
  #   driver.close()
  #   return content, reply_email
  # end

  def get_content(link)
    html = Nokogiri::HTML(open(link))
    content = html.css('#postingbody').text
    content.sub!("\n        \n            QR Code Link to This Post\n            \n        \n", '')
    return content
  end

  def generate_city_list()
    url = 'https://geo.craigslist.org/iso/ca'
    html = Nokogiri::HTML(open(url))
    city_list = []
    html.css('.geo-site-list').css('li').each do |node|
      city = node.text
      city_link = node.at('a')['href']
      city_link += '/search/cpg?'
      city_list << [city, city_link]
      # puts city, city_link
    end
    p '------ finish city lists ------'
    t = rand(3..8)
    puts "sleep for #{t} seconds"
    sleep(t)
    city_list
  end

  def generate_partial_result(gig, city)
    pid = get_pid gig
    datetime = get_datetime(gig).to_datetime
    link, title = get_link_n_title gig

    unless pid_exist?(pid) || title_exist?(title)
      ScrapResult.create(city: city,
                         pid: pid,
                         post_url: link,
                         title: title,
                         datetime: datetime)
    end
  end

  def process_city()
    city_list = generate_city_list
    random_sleep

    city_list.each do |city, url|
      html = generate_doc(url)
      gigs = get_all_rows(html)
      gigs.each do |gig|
        generate_partial_result(gig, city)
      end
      random_sleep(4)
    end
  end

  # def filter_ignore_pid(list)
  #   return list - @@pid_ignore_list
  # end

  # def generate_pid_history_set(list)
  #   list.each do |pid|
  #     @@pid_history << pid
  #   end
  # end

  # def generate_pid_ignore_list_from_csv
  #   p '------ generate pid ignore list from csv ------'
  #   CSV.foreach('pid_ignore.csv') do |row|
  #     @@pid_ignore_list << row[1]
  #   end
  #   p 'pid_ignore_list: ', @@pid_ignore_list
  # end

  # def turn_set_to_list(set)
  #   ignore_list = []
  #   set.each do |pid|
  #     ignore_list << pid
  #   end
  #   return ignore_list
  # end

  # def generate_pid_ignore_csv
  #   today = Date.today.to_s
  #   # result = [today]
  #   @@pid_history.each do |pid|
  #     result = [today, pid]
  #     CSV.open('pid_ignore.csv', 'a') do |csv|
  #       csv << result
  #     end
  #   end
  #   # result = [today, ignore_list]

  #   # p 'ignore_list888: ', result
  # end

  # def test_generate_city_list
  #   add_to_list('vancouver', 'https://vancouver.craigslist.ca/search/cpg?')
  #   # add_to_list('bellingham', 'https://bellingham.craigslist.org/search/cpg?')
  #   # add_to_list('prince george', 'https://princegeorge.craigslist.ca/search/cpg?')
  #   puts '------ test city list generated ------'
  # end

  # true if title not in @@title
  def test_title_validator(title)
    if @@title.include?(title)
      return false
    else
      return true
    end
  end
end