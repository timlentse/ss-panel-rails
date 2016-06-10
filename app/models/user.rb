class User < ActiveRecord::Base

  self.table_name = 'user'
  self.inheritance_column = 'another_type'

  has_one :user_token, foreign_key: :user_id

  include BCrypt

  def user_id
    "00000#{id}"[-6..-1]
  end

  # def password
  #   @password ||= Password.new(pass)
  # end
  #
  # def password=(new_password)
  #   @password = Password.create(new_password)
  #   self.pass = @password
  # end

  def password=(new_passwd)
    self.pass = Digest::SHA256.hexdigest(new_passwd)
  end
  def another_way(password_ori)
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
