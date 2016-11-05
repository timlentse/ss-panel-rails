class CommonsController < ApplicationController
  skip_before_action :validate_login_status
  before_action :get_current_user

  def welcome
    @index = true
  end

  def code
    @codes = InviteCode.where(user_id:0,used:0).limit(50)
  end

  private 
  def get_current_user
    @current_user = current_user
  end
end
