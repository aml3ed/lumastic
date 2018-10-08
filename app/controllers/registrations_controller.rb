#
# Manage user registrations
#
class RegistrationsController < Devise::RegistrationsController
  include ApplicationHelper
  layout 'application'

  def sign_up_params
    params.require(:user).permit(:display_name, :email, :password, :password_confirmation)
  end
end
