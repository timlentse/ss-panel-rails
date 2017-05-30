class Admin::UsersController < ApplicationController

  before_action :validate_admin, :get_traffic_usage, :check_in?
  before_action :set_user_params, only: [:update,:create]

  def index
    @users = User.paginate(:page=>params[:page])
  end

  def edit
    @user = User.find_by_id(params[:id])
    redirect_to "/404.html" and return unless @user
  end

  def update
    @user = User.find_by_id(params[:id])
    if @user and @user.update(@user_params)
      redirect_to "/admin/users",notice:"修改成功!"
    elsif @user
      render "edit",:flash=>{:alert=>@user.errors.messages}
    else
      render "edit",:flash=>{:alert=>"用户不存在"}
    end
  end

  def create
    Settings.skip_invited_code = true
    @user = User.new(@user_params)
    @user.password = @user_params[:passwd]
    @user.transfer_enable = Settings.default_traffic
    @user.port = User.last.port+1
    @user.reg_ip = request.remote_ip
    if @user.save 
      redirect_to "/admin/users",notice: "新建成功!"
    else
      flash.now[:alert] = @user.errors.messages
      render "new"
    end
  end

  def new
  end

  def destroy
    @user = User.find_by_id(params[:id])
    name = @user.user_name
    if @user and @user.destroy
      redirect_to "/admin/users", notice:"删除用户#{name}成功!"
    elsif @user
      redirect_to "/admin/users", :flash=>{:alert=>@user.errors.messages}
    else
      redirect_to "/admin/users", :flash=>{:alert=>"用户不存在"}
    end
  end

  private

  def set_user_params
    @user_params = params.require(:user).permit(:user_name,:email,:passwd,:transfer_enable,:port,:pass)
    @user_params[:encrypted_password] = Digest::SHA256.hexdigest(@user_params[:pass]) unless @user_params[:pass].blank?
    @user_params[:transfer_enable] = @user_params[:transfer_enable].to_i * 1024**3
    @user_params.delete(:pass)
  end

end
