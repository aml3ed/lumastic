class ApplicationController < ActionController::Base
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to new_user_registration_path, :alert => exception.message
  end
  before_action :my_communities

  private
  def my_communities
    if current_user
      @my_communities = current_user.communities
    end
  end
end
