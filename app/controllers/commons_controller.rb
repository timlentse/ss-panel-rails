class CommonsController < ApplicationController
  skip_before_action :validate_login_status

  def welcome
    if @session_token and user_id=@redis.get_session_token(@session_token)
      @current_user = User.find_by_id(user_id.to_i)
    end
    @index = true
  end

end
