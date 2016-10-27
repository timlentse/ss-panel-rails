desc "reset the traffic"
task :reset_traffic=>:environment do
  User.find_each do |user|
    user.update(d:0,u:0)
  end
end
