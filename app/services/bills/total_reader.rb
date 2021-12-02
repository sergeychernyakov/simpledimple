# frozen_string_literal: true
# this service will read the total from bill attachment

class Bills::TotalReader
  def initialize(payment_request)
    @payment_request = payment_request
  end

  def read

    read_bill_from_attachment
    @payment_request
  end

  private

  def read_bill_from_attachment
    if @payment_request.bill_attachment.attached?
      bill_reader = RTesseract.new(ActiveStorage::Blob.service.send(:path_for, @payment_request.bill_attachment.key))
      bill_total = bill_reader.to_s.downcase.split("total").last.split("\n").first.to_s.scan(/\d+/).join(".")
      if bill_total.present?
        @payment_request.bill_total = bill_total
      else
        @payment_request.invalid_bill_attachment = true
      end
    elsif @payment_request.bill_total.to_f.zero?
      @payment_request.invalid_bill_attachment = true
    end
  end
end
