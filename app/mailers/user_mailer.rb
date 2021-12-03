# frozen_string_literal: true

class UserMailer < ApplicationMailer
  def notification_email
    mail(to: ENV['ADMIN_EMAIL'], subject: 'Verification code sending failed')
  end
end
