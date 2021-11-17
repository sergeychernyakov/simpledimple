class TwilioMailer < ApplicationMailer
  def send_email(user)
    @user = user
    @phone = @user.phone

    @from = ENV['DEFAULT_FROM_EMAIL']
    mail(to: ENV['ADMIN_EMAIL'], subject: 'Verification code sending failed')
  end
end
