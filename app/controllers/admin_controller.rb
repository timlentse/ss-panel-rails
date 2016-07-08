class AdminController < ApplicationController

  before_action :validate_admin,:get_traffic_usage, :check_in?

  def index
    @total_traffic, @checked_num = 0, 0
    @online_last_one_hour = 0
    User.find_each do |user|
      @total_traffic=@total_traffic+user.d+user.u
      @checked_num+=1 if Time.at(user.last_get_gift_time)>Time.now-1.day
      @online_last_one_hour+=1 if Time.at(user.t)>Time.now-1.hour
    end
  end

  def search
    @users = User.where("user_name like '%#{params[:kw]}%' or email like '%#{params[:kw]}%'").paginate(:page=>params[:page])
  end

  def traffic
  end

  def configuration
  end

end
