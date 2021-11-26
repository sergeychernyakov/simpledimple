class BillingDetail < ApplicationRecord
  WHITELIST_ATTRIBUTE = %i[
    id
    phone
    payment_request_id
    user_id
    _destroy

  ].freeze

  belongs_to :payment_request
  belongs_to :user

  validates :phone, presence: true
end
