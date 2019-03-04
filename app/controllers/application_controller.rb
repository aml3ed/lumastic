class ApplicationController < ActionController::Base
  rescue_from CanCan::AccessDenied do |exception|
    puts "***** THIS IS AN EXCEPTION *****"
    puts exception.action
    if current_user.blank?
      redirect_to new_user_registration_path, :alert => "Woops! Try creating an account first."
    else
      redirect_to request.referer.nil? ? root_path : request.referer, :alert => exception.message
    end


  end
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :store_user_location!, if: :storable_location?
  before_action :my_communities

  protected


    def configure_permitted_parameters
      # Permit the `subscribe_newsletter` parameter along with the other
      # sign up parameters.
      devise_parameter_sanitizer.permit(:account_update, keys: [:display_name, :avatar])
    end

  private
    def my_communities
      if current_user
        @my_communities = current_user.communities.order(:name)
      end
    end

    def storable_location?
      request.get? && is_navigational_format? && !devise_controller? && !request.xhr?
    end

    def store_user_location!
      store_location_for(:user, request.fullpath)
    end




end
