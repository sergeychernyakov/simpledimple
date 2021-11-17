class ApplicationController < ActionController::Base
  protect_from_forgery prepend: true

  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def user_verified_authentication
    if current_user && !current_user.is_verified?
      return redirect_to verification_screen_users_path, alert: 'You are not verified user'
    end
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[email password password_confirmation phone])
  end
end
