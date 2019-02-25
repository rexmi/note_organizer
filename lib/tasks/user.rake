task :set_admin => :environment do
  user = User.find(:email=>'rex@gmail.com')
  p "user is: ", user

  user.update_attribute(:role, 'admin')
end