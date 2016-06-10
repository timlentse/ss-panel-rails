class CommonsController < ApplicationController
  skip_before_action :validate_login_status

  def welcome
    if session[:user_id]
      @current_user = User.find_by_id(session[:user_id])
    end
  end

end
