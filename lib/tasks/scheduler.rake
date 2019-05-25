task :test_task => :environment do
  240.times do |t|
    puts "#{t} sec"
    sleep(1.0)
  end
end