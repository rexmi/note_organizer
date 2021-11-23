task :clean_old_gigs => :environment do
  id_list = ScrapResult.where("datetime > ?", Time.zone.parse("2021-10-01")).pluck(:id)
  ScrapResult.all.each do |s|
    unless id_list.include? s.id
      s.destroy
    end
  end
end