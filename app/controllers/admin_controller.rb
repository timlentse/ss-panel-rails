class AdminController < ApplicationController
  before_action :validate_admin, :get_traffic_usage, :check_in?

  def index
    @total_traffic, @checked_num = 0, 0
    @online_last_one_hour = 0
    User.find_each do |user|
      @total_traffic = @total_traffic + user.d + user.u
      @checked_num += 1 if Time.at(user.last_get_gift_time) > 1.day.ago
      @online_last_one_hour += 1 if Time.at(user.t) > 1.hour.ago
    end
  end

  def search
    @users = User.where("user_name like '%#{params[:kw]}%' or email like '%#{params[:kw]}%'").paginate(page: params[:page])
  end

  def traffic
  end

  def invite
    if params[:num]
      params[:num].to_i.times { InviteCode.create(code: SecureRandom.uuid, user_id: 0) }
      render json: { code: 1, msg: 'success' }
    else
      render json: { code: 0, msg: 'invalid number' }
    end
  end

  def configuration
    if request.post?
      site_config = SiteConfig.find_or_initialize_by(key: 'user-index')
      if params[:site_config] && params[:site_config][:value] && !params[:site_config][:value].empty?
        site_config.value = params[:site_config][:value]
        if site_config.save
          redirect_to '/admin/configuration', notice: '修改公告成功'
        else
          flash.now[:alert] = '修改错误'
        end
      end
    end
  end
end
