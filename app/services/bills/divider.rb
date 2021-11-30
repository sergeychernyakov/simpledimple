# frozen_string_literal: true

class Bills::Divider
  def initialize(payment_request)
    @payment_request = payment_request
    @total = payment_request&.bill_total
  end

  def call
    return if invalid?

    divide_and_send
  end

  private

  attr_accessor :payment_request, :total

  def divide_and_send
    total_bill_payer = recipients.count + 1
    @per_head = (total / total_bill_payer).to_f
    update_recipients
    send_bill_notifications
  end

  def recipients
    payment_request.billing_details
  end

  def invalid?
    payment_request.blank? || recipients.blank? || total == 0.0
  end

  def update_recipients
    recipients.update_all(per_head: @per_head)
  end

  def send_bill_notifications
    Twilio::BillNotificationSender.new(payment_request).send!
  end
end
