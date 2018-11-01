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

  def sign_up_params
    params.require(:user).permit(:display_name, :email, :password, :password_confirmation)
  end
end
