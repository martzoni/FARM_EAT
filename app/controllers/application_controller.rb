class ApplicationController < ActionController::Base
  before_action :store_user_location!, unless: :devise_controller? 
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def after_sign_in_path_for(resource)
    stored_location_for(resource)
  end

  def store_user_location!    # :user is the scope we are authenticating
    store_location_for(:user, request.url)
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:is_farmer])
    devise_parameter_sanitizer.permit(:account_update, keys: [:is_farmer])
  end
end
