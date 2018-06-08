class ApplicationController < ActionController::Base
  protect_from_forgery
  before_action :authenticate_user!

  protected

  def configure_permitted_parameters
    added_attrs = [:username, :email, :password, :password_confirmation,
               :remember_me, :first_name, :last_name, :phone, :location]

    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
  end
end
