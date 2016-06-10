class UserMailer < ApplicationMailer

  def send_token(user,url)
    @user = user
    @url = url
    mail to: @user.email, subject: 'Welcome to ss.tan90.cn'
  end

end
