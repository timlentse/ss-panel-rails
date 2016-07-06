desc "log each day traffic log"
task :traffic=>:environment do
  User.find_each do |user|
    found = UserTrafficLog.where(:user_id=>user.id).order(id: :desc).first
    if found
      traffic = (user.d+user.u-found.d-found.u)/1024
      UserTrafficLog.create(user_id: user.id,u: user.u,d: user.d,node_id:1,traffic: traffic,rate:1.0,log_at:Time.now)
    else
      UserTrafficLog.create(user_id: user.id,u: user.u,d: user.d,node_id:1,traffic:0,rate:1.0,log_at:Time.now)
    end
  end
end
