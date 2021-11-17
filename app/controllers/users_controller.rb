class UsersController < ApplicationController

  def verification_screen;  end

  def verification
    if current_user.verification_code == params[:verification_code]
      current_user.update_column(:is_verified, true)
      redirect_to root_path, notice: 'User verifified successfully'
    else
      redirect_to verification_screen_users_path, alert: 'Invalid verification code'
    end
  end

  def resend_verification_code
    current_user.send_verfivation_code
    redirect_to verification_screen_users_path, notice: 'Verification code has been sent'
  end

end 