#
# Manage user registrations
#
class RegistrationsController < Devise::RegistrationsController
  include ApplicationHelper
  layout 'application'

  def create
    super

    if Community.first.present?
      community = Community.where(name: "Lumastic Community").first
      Membership.create!(community: community, user: resource)
    end
  end

  protected
    def sign_up_params
      params.require(:user).permit(:display_name, :email, :password, :password_confirmation)
    end

    def update_resource(resource, params)
      devise_parameter_sanitizer.permit(:account_update, keys: [:display_name])
      # Require current password if user is trying to change password.
      return super if params["password"]&.present?

      # Allows user to update registration information without password.
      resource.update_without_password(params.except("current_password"))
    end
end
