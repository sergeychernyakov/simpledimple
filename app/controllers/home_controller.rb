class HomeController < ApplicationController
  before_action :user_verified_authentication
  def index
    @payment_request = current_user.payment_requests
  end
end
