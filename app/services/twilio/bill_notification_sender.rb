# frozen_string_literal: true

class Twilio::BillNotificationSender
  def initialize(payment_request)
    @payment_request = payment_request
  end

  def send!
    send_notification
  end

  private

  attr_accessor :payment_request

  def send_notification
    return if payment_request.blank? || recipients.blank?

    recipients.each do |recipient|
      Twilio::SmsSender.new(recipient,
                            "Here is your per head bill: #{recipient.per_head} against #{payment_request.title}").send!
    end
  end

  def recipients
    payment_request.billing_details
  end
end
