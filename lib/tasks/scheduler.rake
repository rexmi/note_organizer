task :test_task => :environment do
  include Assets::Scrap_Folder::Scrap_Logic

  queue = ScrapResult.where(content: nil)
  break if queue.empty?

  queue.first(5).each do |q|
    q.content = get_content(q.post_url)
    q.save
    t = rand(3..9)
    puts "#{q.pid}, #{truncate(q.title, length: 28)} finished"
    sleep(t)
    puts "slept for #{t} seconds"
  end
end

task :scrap_each_city => :environment do
  include Assets::Scrap_Folder::Scrap_Logic

  process_city
end