class CommonsController < ApplicationController
  skip_before_action :validate_login_status
  before_filter :get_current_user

  def welcome
    @index = true
  end

  def code
    @codes = InviteCode.where(user_id:0,used:0).limit(50)
  end

  private 
  def get_current_user
    if @session_token and user_id=@redis.get_session_token(@session_token)
      @current_user = User.find_by_id(user_id.to_i)
    end
  end
end
