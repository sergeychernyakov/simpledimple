# frozen_string_literal: true

class Twilio::SmsSender
  def initialize(user)
    @user = user
    @phone = user.phone
    @twilio_client = Twilio::REST::Client.new ENV['ACCOUNT_SID'], ENV['AUTH_TOKEN']
    @errors = []
  end

  def send!
    send_sms if valid?
    @twilio_msg_obj
  end

  def uniq_errors
    errors.uniq
  end

  def valid?
    validate
    !uniq_errors.present?
  end

  attr_accessor :user, :phone, :errors, :twilio_client

  private

  def send_sms
    @twilio_msg_obj = twilio_client.messages.create(twilio_request_params)
  rescue Exception => e
    Rails.logger.debug e
    errors << "Message sending failed!#{e.message}"
    TwilioMailer.send_email(user).deliver
  end

  def validate
    errors << "Recipient number can't be blank" if phone.blank?
  end

  def body
    @body ||= "#{@user.verification_code} is your verification code"
  end

  def twilio_request_params
    params = {
      to: phone,
      from: ENV['TWILIO_FROM'],
      body: body
    }
    params
  end
end
