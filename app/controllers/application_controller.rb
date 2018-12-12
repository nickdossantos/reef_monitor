class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :set_user, unless: :devise_controller?

  layout :layout_by_resource

  def after_sign_in_path_for(resource)
    dashboard_path(resource.id)
  end

  private
  def set_user
    @user = current_user
  end

  def layout_by_resource
    if devise_controller?
      "authentication"
    else
      "application"
    end
  end

end
