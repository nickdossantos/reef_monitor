class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :set_user, unless: :devise_controller?
  before_action :set_tank, unless: :devise_controller?

  layout :layout_by_resource

  def after_sign_in_path_for(resource)
    # dashboard_path(resource.id)
    pages_tanks_path
  end

  private
  def set_user
    @user = current_user
  end

  def set_tank
    if params[:tank_id]
      @tank = @user.tanks.find(params[:tank_id])
    end
  end

  def layout_by_resource
    if devise_controller?
      "authentication"
    else
      "application"
    end
  end

end
