class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable

  validates :email, :password, :password_confirmation, :phone, presence: true
  validates :email, :phone, uniqueness: true

  after_create :send_verfivation_code

  has_many :billing_details, dependent: :destroy
  has_many :payment_requests, through: :billing_details

  def to_s
    "#{first_name} #{last_name}"
  end

  def send_verfivation_code
    generate_verification_code
    Twilio::SmsSender.new(self, "#{verification_code} is your verification code").send!
  end

  private

  def generate_verification_code
    begin
      code = SecureRandom.rand.to_s[2..5]
    end while User.where(verification_code: code).present?
    self.update_column(:verification_code, code)
  end

end
