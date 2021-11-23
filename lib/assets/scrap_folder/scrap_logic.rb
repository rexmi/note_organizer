require 'nokogiri'
require 'open-uri'
require 'date'
require 'set'
# require 'selenium-webdriver'

module Assets::Scrap_Folder::Scrap_Logic
  def generate_doc(url)
    html = open(url)
    @html = Nokogiri::HTML(html)
  end

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
      city_link += 'search/cpg?'
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

  # true if title not in @@title
  def test_title_validator(title)
    if @@title.include?(title)
      return false
    else
      return true
    end
  end
end