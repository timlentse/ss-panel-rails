class ApplicationController < ActionController::Base

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include ActionView::Helpers::DateHelper

  before_action :init, :validate_login_status
  helper_method :is_login?

  protected

  def init
    @redis = MyRedis.current
    @session_token = cookies[:session_token]
  end

  def validate_login_status
    if @session_token and user_id=@redis.get_session_token(@session_token)
      @current_user = User.find_by_id(user_id.to_i)
      unless @current_user
        redirect_to root_url, status:302
      end
    else
      @current_user = nil
      redirect_to root_url, status:302
    end
  end

  def is_login?
    !@current_user.nil?
  end

  def get_avatar(email)
    hash = Digest::MD5.hexdigest(email)
    "https://www.gravatar.com/avatar/#{hash}?s=50"
  end

  def check_in?
    @checked = Time.at(@current_user.last_get_gift_time)>Time.now-1.day
  end

  def give_session_token
    token_string = SecureRandom.uuid
    cookies[:session_token] = {:value=>token_string,:expires=>1.week.from_now}
    @redis.set_session_token(cookies[:session_token],@user.id,604800)
  end

  def delete_session_token
    @redis.delete_session_token(@session)
    cookies.delete :session_token
  end

  def validate_admin
    redirect_to "/user" unless @current_user.is_admin?
  end

  def get_traffic_usage
    @usage = (@current_user.d+@current_user.u)/@current_user.transfer_enable.to_f
    @usage = (@usage * 100.0).round(2)
  end

end
