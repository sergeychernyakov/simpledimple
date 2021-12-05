# frozen_string_literal: true
class UserMailer < ApplicationMailer
  def notification_email
    attachments.inline["email-background.png"] = File.read("#{Rails.root}/app/assets/images/email-background.png")
    mail(to: ENV['ADMIN_EMAIL'], subject: 'Verification code sending failed')
  end
end
