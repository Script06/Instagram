class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!

  include Pundit::Authorization

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username])
    devise_parameter_sanitizer.permit(:sign_in, keys: [:username])
    devise_parameter_sanitizer.permit(:account_update, keys: [:username])
  end

  layout :layout_by_resource

  private

  def layout_by_resource
    if devise_controller? && resource_name == :user && action_name == 'new'
      false # не использовать layout для страницы логина пользователя
    else
      'application' # использовать обычный layout для других страниц
    end
  end
end
