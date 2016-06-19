class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include ActionView::Helpers::DateHelper

  before_action :set_params, :validate_login_status
  helper_method :is_login?

  protected
  def set_params
    @params = params.permit(:id,:email,:user_name,:original,:password,:token,:content,:method,:name,:ip_address,:desc,:visable,:page)
    @app_name = Settings.app_name
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
    @checked
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

end
