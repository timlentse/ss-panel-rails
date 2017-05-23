desc "generate invite code for each users"
task :invite_code=>:environment do
  User.find_each do |user|
    5.times do |t|
      token_string = SecureRandom.uuid
      InviteCode.create(code: token_string,user_id: user.id)
    end
  end
end
