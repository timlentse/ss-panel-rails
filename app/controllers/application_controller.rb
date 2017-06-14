class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session, if: proc { |c| c.request.format == 'application/json' }
  include ActionView::Helpers::DateHelper

  before_action :validate_login_status
  before_action :configure_permitted_parameters, if: :devise_controller?
  helper_method :is_login?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:user_name, :invite_code, :reg_ip])
  end

  def is_login?
    !current_user.nil?
  end

  def get_avatar(email)
    hash = Digest::MD5.hexdigest(email)
    "https://www.gravatar.com/avatar/#{hash}?s=50"
  end

  def check_in?
    @checked = Time.at(@current_user.last_get_gift_time) > Time.now - 1.day
  end

  def validate_admin
    redirect_to '/user' unless @current_user.is_admin
  end

  def get_traffic_usage
    @usage = (@current_user.d + @current_user.u) / @current_user.transfer_enable.to_f
    @usage = (@usage * 100.0).round(2)
  end

  def validate_login_status
    @current_user = current_user
    authenticate_user!
  end
end
