# output module
require 'csv'
require 'set'

module Output
  @@pid = Set[]
  # class One_Gig
  #   @@pid_set = Set[]
  #   attr_reader :pid_set

  #   def initialize(city, pid, url, date, title, content)
  #     @city = city
  #     @pid = pid
  #     @post_url = url
  #     @date = date
  #     @title = title
  #     @content = content
  #     @@pid_set << pid
  #   end
  # end

  def turn_into_obj
    obj = yield
    return {city: obj[0],
           pid: obj[1],
           post_url: obj[2],
           date: obj[3],
           title: obj[4],
           content: obj[5]
           # email: obj[3]
    }
  end


  def turn_obj_to_csv(obj)
    # put some kind of logic filter here in the future
    CSV.open('test.csv', 'a') do |csv|
      csv << obj.values
    end
  end

  def turn_cvs_to_obj
    array = yield
    return {city: array[0],
            pid: array[1],
            post_url: array[2],
            # email: array[3],
            date: array[3],
            title: array[4],
            content: array[5]
    }
  end
end