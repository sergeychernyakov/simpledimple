class PaymentRequest < ApplicationRecord
  WHITELIST_ATTRIBUTE = [
    :title,
    :description,
    :bill_attachment,
    { billing_details_attributes: BillingDetail::WHITELIST_ATTRIBUTE }

  ].freeze

  has_one_attached :bill_attachment

  has_many :billing_details, dependent: :destroy

  validates :title, presence: true

  accepts_nested_attributes_for :billing_details, reject_if: ->(a) { a[:phone].blank? }, allow_destroy: true
end
