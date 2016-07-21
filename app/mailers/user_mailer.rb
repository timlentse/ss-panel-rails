class UserMailer < ApplicationMailer
  def send_verify(user,url)
    @user = user
    @url = url
    mail to: @user.email, subject: 'Welcome to ss.tan90.cn'
  end

  def send_token(user,url)
    @user = user
    @url = url
    mail to: @user.email, subject: 'Reset your password'
  end

  def send_group_email(emails,subject,template)
    mail to: emails, subject: subject,template_name: template
  end

end
