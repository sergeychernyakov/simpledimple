class HomeController < ApplicationController
  before_action :user_verified_authentication
  def index; end
end
