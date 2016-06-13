class User < ActiveRecord::Base

  self.table_name = 'user'
  self.inheritance_column = 'another_type'

  has_one :user_token, foreign_key: :user_id

  def user_id
    "00000#{id}"[-6..-1]
  end

  def password=(new_passwd)
    self.pass = Digest::SHA256.hexdigest(new_passwd)
  end

  def authenticate(password_ori)
    self.pass == Digest::SHA256.hexdigest(password_ori)
  end

  def is_admin?
    is_admin==1
  end

  def avatar
    hash = Digest::MD5.hexdigest(email)
    "https://www.gravatar.com/avatar/#{hash}?s=50"
  end

  def last_checkin_time
    distance_of_time_in_words(Time.at(last_check_in_time))
  end

end
