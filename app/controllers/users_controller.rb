class UsersController < ApplicationController

  before_action :get_traffic_usage, :check_in?
  after_action :clear_flash, only: [:home]

  def home
    @comments = fetch_all_comments
    @nodes_count = Node.where(:cata=>1).count
    @comments_count = UserComment.count
    @traffics = UserTrafficLog.where(user_id: @current_user.id).last(10)
    @config = SiteConfig.find_by_key("user-index")
    if @config
      flash.now[:announcement] = @config.value
    end
  end

  def node
    if @current_user.is_offer? or @current_user.is_admin
      @nodes = Node.all
    else
      @nodes = Node.where(cata:1)
    end
  end

  def profile
    @checkin_time = human_readable_time(@current_user.last_get_gift_time)
    @login_time = human_readable_time(@current_user.last_check_in_time)
    @reg_date = human_readable_time(@current_user.created_at.to_i)
  end

  def traffic
    @traffics = UserTrafficLog.where(user_id: @current_user.id).order(log_at: :desc).limit(10)
  end

  def change
  end

  def invite
    @codes = InviteCode.select(:code,:used).where(:user_id=>@current_user.id)
  end

  def check_in
    if @checked
      render json: {code:0,msg:"你已经签到"}
    else
      @current_user.last_get_gift_time=Time.now.to_i
      @current_user.transfer_enable+=104857600
      @current_user.save
      render json: {code:1,msg:"签到成功"}
    end
  end

  def change_password
    if @current_user.authenticate(user_params[:original])
      @current_user.password = user_params[:password]
      if @current_user.save
        render json: {code: 1, msg:"修改成功"}
      else
        render json: {code: 0, msg:"修改失败"}
      end
    else
      render json: {code: 0, msg: "原密码错误"}
    end
  end

  def change_username
    @current_user.user_name = user_params[:user_name]
    if @current_user.save
      render json: {code: 1, msg: "修改成功"}
    else
      render json: {code: 0 , msg: "修改失败"}
    end
  end

  def change_connect_password
    @current_user.passwd = user_params[:password]
    if @current_user.save
      render json: {code: 1, msg: "修改成功"}
    else
      render json: {code: 0 , msg: "修改失败"}
    end
  end

  def avatar
    if avatar_params and @current_user.update(avatar:avatar_params[:avatar])
      update_comments_avatar
      redirect_to "/user/profile", notice: "头像更改成功"
    elsif avatar_params
      flash.now[:error] = "更改头像失败:#{@current_user.errors.messages[:avatar]}"
      render 'profile'
    else
      flash.now[:error] = "更改头像失败:请选择文件"
      render 'profile'
    end
  end

  def destroy
    if @current_user.destroy
      delete_session_token
      @current_user = nil
      redirect_to "/", notice:"账号注销成功!"
    else
      redirect_to "/user", :flash=>{:error=>@user.errors.messages}
    end
  end

  def sponsor
  end

  private

  def fetch_all_comments
    UserComment.all.map do |comment|
      comment_time = time_ago_in_words(comment.created_at)
      {id: comment.id, content: comment.content,user_name: comment.user_name, avatar: comment.avatar,time: comment_time }
    end
  end

  def human_readable_time(int_time)
    if int_time==0
      return "从未签到"
    else
      return time_ago_in_words(Time.at(int_time))
    end
  end

  def clear_flash
    flash[:notice] = nil
  end

  def avatar_params
    params[:user].nil? ? nil : params.require(:user).permit(:avatar)
  end

  def update_comments_avatar
    @current_user.user_comments.find_each do |comment|
      comment.update(avatar: @current_user.avatar.url(:thumb))
    end
  end

  def user_params
    params.permit(:original,:password,:content,:method,:user_name)
  end

end
