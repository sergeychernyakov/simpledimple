# frozen_string_literal: true

class Twilio::SmsSender
  def initialize(obj, message)
    @obj = obj
    @phone = obj.phone
    @message = message
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

  attr_accessor :obj, :phone, :errors, :twilio_client, :message

  private

  def send_sms
    @twilio_msg_obj = twilio_client.messages.create(twilio_request_params)
  rescue Exception => e
    Rails.logger.debug e
    errors << "Message sending failed!#{e.message}"
    TwilioMailer.send_email(obj).deliver
  end

  def validate
    errors << "Recipient number can't be blank" if phone.blank?
  end

  def twilio_request_params
    {
      to: phone,
      from: ENV['TWILIO_FROM'],
      body: message
    }
  end
end
