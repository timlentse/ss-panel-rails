class AdminsController < ApplicationController

  before_action :validate_admin, :check_in?

  def admin
    @total_traffic = 0
    @checked_num = 0
    @online_last_one_hour = 0
    User.find_each do |user|
      @total_traffic=@total_traffic+user.d+user.u
      @checked_num+=1 if Time.at(user.last_get_gift_time)>Time.now-1.day
      @online_last_one_hour+=1 if Time.at(user.t)>Time.now-1.hour
    end
  end

  def node
    @nodes = Node.all
  end

  def traffic
  end

  def user
    @users = User.paginate(:page=>@params[:page])
  end

  def configuration
  end

  private
  def validate_admin
    redirect_to "/user" unless @current_user.is_admin?
  end

end
