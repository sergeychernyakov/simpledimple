# frozen_string_literal: true

class Twilio::BillNotificationSender
  def initialize(payment_request)
    @payment_request = payment_request&.reload
  end

  def send!
    send_notification
  end

  private

  attr_accessor :payment_request

  def send_notification
    return if payment_request.blank? || recipients.blank?

    recipients.each do |recipient|
      Twilio::SmsSender.new(recipient, message_body(recipient)).send!
    end
  end

  def recipients
    payment_request.billing_details
  end

  def message_body(recipient)
    "Here is your per head bill: #{recipient.per_head.round(2)} against #{payment_request.title}. You can follow this link to pay bill. #{payment_link(recipient)}"
  end

  def payment_link(recipient)
    payment_long_url = "https://venmo.com/?txn=charge&audience=friends&recipients=#{recipient.phone}&amount=#{recipient.per_head.round(2)}"
    ShortUrlCreator.new(payment_long_url).create!
  end
end
