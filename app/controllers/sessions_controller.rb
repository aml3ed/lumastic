#
# Manage user sessions
#
class SessionsController < Devise::SessionsController

  def create
    super

    flash[:notice] = "Welcome back, #{resource.display_name}!"
  end

end