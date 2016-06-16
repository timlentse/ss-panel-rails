class UsersController < ApplicationController

  before_action :init_var, :check_in?
  after_action :clear_flash

  def index
    @comments = fetch_all_comments
    @nodes_count = Node.where(:cata=>1).count
    @comments_count = UserComment.count
    @traffics = UserTrafficLog.where(user_id: @current_user.id).limit(10)
  end

  def node
    @nodes = Node.where(:cata=>1)
  end

  def profile
    @checkin_time = human_readable_time(@current_user.last_get_gift_time)
    @login_time = human_readable_time(@current_user.last_check_in_time)
    @reg_date = human_readable_time(@current_user.reg_date)
  end

  def traffic
    @traffics = UserTrafficLog.where(user_id: @current_user.id).limit(10)
  end

  def edit
  end

  def invite
    @codes = InviteCode.where(:user_id=>@current_user.id)
  end

  def comments
    @comment = UserComment.new(user_name: @current_user.user_name,email:@current_user.email)
    @comment.content = @params[:content]
    if @comment.save
      @comments = fetch_all_comments
      # render json: {code:1,data:@comments}
      render 'comments.js.erb'
    else
      render json: {code:0,data:[]}
    end
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
    if @current_user.authenticate(@params[:original])
      @current_user.password=@params[:password]
      if @current_user.save
        render json: {code: 1, msg:"修改成功"}
      else
        render json: {code: 0, msg:"修改失败"}
      end
    else
      render json: {code: 0, msg: "原密码错误"}
    end
  end

  def change_connect_password
    @current_user.passwd = @params[:password]
    if @current_user.save
      render json: {code: 1, msg: "修改成功"}
    else
      render json: {code: 0 , msg: "修改失败"}
    end
  end

  private

  def fetch_all_comments
    UserComment.all.map do |comment|
      comment_time = distance_of_time_in_words(comment.created_at,Time.now)
      {content: comment.content,user_name: comment.user_name, avatar: get_avatar(comment.email),time: comment_time }
    end
  end

  def human_readable_time(int_time)
    if int_time==0
      return "从未签到"
    else
      return distance_of_time_in_words(Time.at(int_time),Time.now)
    end
  end

  def init_var
    @usage = (@current_user.d+@current_user.u)/@current_user.transfer_enable.to_f
    @usage = (@usage * 100.0).round(2)
  end

  def clear_flash
    flash[:notice] = nil
  end

end
