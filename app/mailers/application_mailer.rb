class ApplicationMailer < ActionMailer::Base
  default from: Settings.mailgun_sender
  layout 'mailer'
end
