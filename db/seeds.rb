# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
###################### Create admin account ######################

user_name = "admin"
email = "admin@example.org"
passwd = "admin"
@user = User.new(user_name: user_name, email: email, passwd: passwd, is_admin: 1)
@user.password = passwd
@user.transfer_enable = Settings.default_traffic
@user.port = User.last.nil? ? Settings.init_port : User.last.port+1
if @user.save
  puts 'create an admin user successful!'
else
  warn "create admin failed : #{@user.errors.messages}"
end
