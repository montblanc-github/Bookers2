class GroupMailer < ApplicationMailer
  default from: '管理人<ENV["KEY"]>'
  layout 'mailer'

  def send_mail(mail_title,mail_content,group_users)
    @mail_title = mail_title
    @mail_content = mail_content
    mail bcc: group_users.pluck(:email), subject: mail_title
  end
end
