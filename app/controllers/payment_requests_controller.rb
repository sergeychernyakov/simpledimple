class PaymentRequestsController < ApplicationController
  before_action :user_verified_authentication
  before_action :load_payment_request, only: %i[show]

  def index
    @payment_request = current_user.payment_requests
  end

  def create
    @payment_request = PaymentRequest.new(payment_request_params)
    if @payment_request.save
      redirect_to(payment_requests_path, notice: 'Payment Request Created Successfully')
    else
      render :new
    end
  end

  def new
    @payment_request = PaymentRequest.new
    @payment_request.billing_details.new
  end

  def show;end

  private

  def load_payment_request
    @payment_request = PaymentRequest.find_by(id: params[:id])
  end

  def payment_request_params
    params.require(:payment_request).permit(*PaymentRequest::WHITELIST_ATTRIBUTE)
  end
end
