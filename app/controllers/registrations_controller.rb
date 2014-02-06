class RegistrationsController < Devise::RegistrationsController

  def sign_up_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation, :current_password, :credit_card_number, :expiration, :billing_zip_code)
  end

  def account_update_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation, :current_password, :credit_card_number, :expiration, :billing_zip_code)
  end

end