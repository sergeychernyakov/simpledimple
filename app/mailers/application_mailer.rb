class ApplicationMailer < ActionMailer::Base
  default from: ENV['DEFAULT_FROM_EMAIL']
  layout 'mailer'
  add_template_helper(EmailHelper)
end
