desc "create admin"
task :create_admin=>:environment do
  user_name = ENV['name']
  email = ENV['email']
  passwd = ENV["passwd"]
  @user = User.new(user_name: user_name, email: email, passwd: passwd,is_admin: 1)
  @user.password = passwd
  @user.transfer_enable = Settings.default_traffic
  @user.port = User.last.nil? ? Settings.init_port : User.last.port+1
  if @user.save
    puts 'create an admin user successful!'
  else
    warn "create admin failed : #{@user.errors.messages}"
  end
end
