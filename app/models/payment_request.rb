class PaymentRequest < ApplicationRecord
  WHITELIST_ATTRIBUTE = [
    :title,
    :description,
    :bill_attachment,
    :bill_total,
    { billing_details_attributes: BillingDetail::WHITELIST_ATTRIBUTE }

  ].freeze

  attr_accessor :invalid_bill_attachment

  has_one_attached :bill_attachment

  has_many :billing_details, dependent: :destroy

  validates :title, presence: true

  validate :upload_valid_bill_with_total

  accepts_nested_attributes_for :billing_details, reject_if: ->(a) { a[:phone].blank? }, allow_destroy: true

  def upload_valid_bill_with_total
    return if invalid_bill_attachment.blank?
    errors.add(:base, "Please upload a valid clear image for bill or type total amount.")
  end

end
