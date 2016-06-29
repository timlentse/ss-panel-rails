class User < ActiveRecord::Base

  self.table_name = 'user'
  self.inheritance_column = 'another_type'

  has_one :user_token, foreign_key: :user_id
  has_many :user_comments, foreign_key: :user_id

  has_attached_file :avatar, styles: { medium: "100x100#", thumb: "30x30#" }, url: "/system/:class/:attachment/:id_partition/:style/:hash.jpg", hash_secret: Settings.hash_secret,:hash_data => ":class/:attachment/:id",default_url: "/default_avatar.jpg"

  validates_attachment :avatar, content_type: { content_type: /\Aimage\/.*\Z/, :message=>"文件格式不对" },
    size: { in: 0..500.kilobytes ,:message => "图片文件大小不能超过500kb"}

  validates :user_name, presence:{:message=>"用户名不能为空"}
  validates :email, presence: {:message=>"邮箱不能为空"}, uniqueness: {:message=>"邮箱已被注册"}

  def self.validate_email(email)
    !email.nil? and !email.empty? and email[/\w+@.+/]
  end

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

  def is_offer?
    type==2
  end

  def last_checkin_time
    distance_of_time_in_words(Time.at(last_check_in_time))
  end

end
