class AuthenticationsController < ApplicationController

  skip_before_action :validate_login_status

  def login
    if request.post?
      user = User.find_by_email(@params[:email])
      if user and user.authenticate(@params[:password])
        session[:user_id] = user.user_id
        render json: {code:1,msg:"登录成功"}
        user.update(last_check_in_time: Time.now.to_i)
        flash[:notice] = "Welcome back #{user.user_name}!"
      else
        render json: {code:0,msg:"邮箱或密码错误"}
      end
    end
  end

  def logout
    session[:user_id], @current_user = nil, nil
    redirect_to root_url, status: 302
  end

  def register
    if request.post?
      render json: {code:0,msg:"邮箱格式错误"} and return unless User.validate_email(@params[:email])
      found = User.find_by_email(@params[:email])
      if found
        render json: {:code=>0,:msg=>"该邮箱已被注册"}
      else
        @user = User.new(user_name: @params[:user_name], email: @params[:email], passwd: @params[:password])
        @user.password = @params[:password]
        @user.transfer_enable = Settings.default_traffic
        @user.port = User.last.port+1
        @user.reg_ip = request.remote_ip
        send_verify_email
        @user.save
        generate_invite_code
        flash[:notice] = "恭喜你，注册成功"
        render json: {:code=>1,:msg=>"注册成功"}
      end
    end
  end

  def password_reset
    if request.post?
      @user = User.find_by_email(@params[:email])
      if @user
        send_token_email
        render json: {code:1,msg:"发送成功!请检查你的邮箱."}
      else
        render json: {code:0,msg:"该邮箱没有注册"}
      end
    end
  end

  def password_token
    if request.post?
      @token = PasswordReset.find_by_token(@params[:token])
      if @token and @token.expire_at>Time.now
        @user = User.find_by_email(@token.email)
        @user.password = @params[:password]
        @user.save
        render json: {code:1,msg:"密码重置成功"}
      else
        render json: {code:0,msg:"token错误或已过期"}
      end
    end
  end

  def verify
    @email = @params[:email]
    @token = @redis.get(@email)
    if @token and @token.eql?(@params[:token])
      @user = User.find_by_email(@email)
      if @user
        @user.update(enable: 1,is_email_verify: 1)
        session[:user_id] = @user.user_id
        @status=1
      else
        @status=-1
      end
    else
      @status=0
    end
  end

  private

  def generate_invite_code
    5.times do |i|
      code = SecureRandom.uuid
      InviteCode.create(code: code, user_id: @user.id)
    end
  end

  def send_verify_email
    token_string = SecureRandom.uuid
    @redis.set_key_with_expire(@user.email,token_string)
    verify_url = "https://ss.tan90.cn/verify?email=#{@user.email}&token=#{token_string}"
    UserMailer.send_verify(@user,verify_url).deliver_now
  end

  def send_token_email
    token_string = SecureRandom.uuid
    expire_at = Time.now+4.hours
    PasswordReset.create(email: @params[:email], token: token_string, expire_at: expire_at) 
    token_url = "https://ss.tan90.cn/password/token/#{token_string}"
    UserMailer.send_token(@user,token_url).deliver_now
  end

end
