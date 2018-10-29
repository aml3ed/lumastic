class ApplicationController < ActionController::Base
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to new_user_registration_path, :alert => exception.message
  end
  before_action :store_user_location!, if: :storable_location?
  before_action :my_communities

  protected
    def after_sign_in_path_for(resource)
      stored_location_for(resource) || super
    end

    def after_sign_up_path_for(resource)
      stored_location_for(resource) || super
    end

    def after_sign_out_path_for(resource)
      stored_location_for(resource) || super
    end

  private
    def my_communities
      if current_user
        @my_communities = current_user.communities
      end
    end

    def storable_location?
      request.get? && is_navigational_format? && !devise_controller? && !request.xhr?
    end

    def store_user_location!
      store_location_for(:user, request.fullpath)
    end




end
