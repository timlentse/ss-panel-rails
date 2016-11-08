class User < ActiveRecord::Base

  self.table_name = 'user'
  self.inheritance_column = 'another_type'
  attr_accessor :invite_code
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable, :encryptable
  validates :user_name, presence:{:message=>"用户名不能为空"}
  validates :email, presence: {:message=>"邮箱不能为空"}, uniqueness: {:message=>"邮箱已被注册"}
  validates_each :invite_code, :on => :create do |record, attr, code_str|
    if Settings.invited_code
      if code_str and code = InviteCode.find_by(code: code_str,used:0)
        code.update(used:1)
        record.ref_by = code.user_id
      else
        record.errors.add attr, "Please enter correct invite code"
      end
    end
  end

  has_one :user_token, foreign_key: :user_id
  has_many :user_comments, foreign_key: :user_id

  has_attached_file :avatar, styles: { medium: "100x100#", thumb: "30x30#" }, url: "/system/:class/:attachment/:id_partition/:style/:hash.jpg", hash_secret: Settings.hash_secret,:hash_data => ":class/:attachment/:id",default_url: "/default_avatar.jpg"

  validates_attachment :avatar, content_type: { content_type: /\Aimage\/.*\Z/, :message=>"文件格式不对" },
    size: { in: 0..500.kilobytes ,:message => "图片文件大小不能超过500kb"}

  before_create :set_port_and_sspass
  after_create :generate_invite_code

  def self.validate_email(email)
    !email.nil? and !email.empty? and email[/\w+@.+/]
  end

  def user_id
    "00000#{id}"[-6..-1]
  end

  def authenticate(password_ori)
    self.encrypted_password == Digest::SHA256.hexdigest(password_ori)
  end

  def is_offer?
    type==2
  end

  def last_checkin_time
    distance_of_time_in_words(Time.at(last_check_in_time))
  end

  def password_salt
    'no salt'
  end

  def password_salt=(new_salt)
  end

  protected

  def generate_invite_code
    5.times{ |i| InviteCode.create(code: SecureRandom.uuid, user_id: self.id)  } if self.errors.messages.empty?
  end

  def set_port_and_sspass
    the_last_port_num = self.class.order(port: :asc).last.port
    self.port = the_last_port_num+1
    self.passwd = SecureRandom.hex(3)
  end

end
