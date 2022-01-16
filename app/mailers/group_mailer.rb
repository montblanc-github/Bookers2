class GroupMailer < ApplicationMailer
  default from: '管理人<ENV["KEY"]>'
  layout 'mailer'
end
