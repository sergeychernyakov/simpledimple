# frozen_string_literal: true

class HomeController < ApplicationController
  skip_before_action :authenticate_user!, only: :index
  before_action :user_verified_authentication

  def index; end

  def dashboard; end
end
