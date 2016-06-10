class AdminsController < ApplicationController

  before_action :validate_admin

  def admin
  end

  def node
    @nodes = Node.all
  end

  def traffic
  end

  def user
    @users = User.limit(20)
  end

  def configuration
  end

  private
  def validate_admin
    redirect_to "/user" unless @current_user.is_admin?
  end

end
