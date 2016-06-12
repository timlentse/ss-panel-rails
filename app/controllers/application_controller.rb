class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include ActionView::Helpers::DateHelper

  before_action :set_params, :validate_login_status
  helper_method :is_login?

  protected
  def set_params
    @params = params.permit(:id,:email,:user_name,:password,:token,:content)
    @app_name = Settings.app_name
  end

  def validate_login_status
    if session[:user_id].nil?
      redirect_to root_url, status:302
    else
      @current_user = User.find_by_id(session[:user_id].to_i)
      unless @current_user
        session[:user_id] = nil
        redirect_to root_url, status:302
      end
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

end
