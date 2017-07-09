desc 'record daily traffic log'
task traffic: :environment do
  User.find_each do |user|
    found = UserTrafficLog.where(user_id: user.id).order(id: :desc).first
    this_month = Date.today.month
    if found && found.log_at.month == this_month
      traffic = (user.d + user.u - found.d - found.u) / 1024
    else
      traffic = (user.d + user.u) / 1024
    end
    UserTrafficLog.create(user_id: user.id, u: user.u, d: user.d, node_id: 1, traffic: traffic, rate: 1.0, log_at: Time.now)
  end
end
