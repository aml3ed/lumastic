#
# Manage user sessions
#
class SessionsController < Devise::SessionsController

  def create
    super

    flash[:notice] = "Welcome back, #{resource.display_name}!"
  end

  protected
    def after_sign_in_path_for(resource)
      stored_location_for(resource) || super
    end

    def after_sign_out_path_for(resource)
      stored_location_for(resource) || super
    end

end