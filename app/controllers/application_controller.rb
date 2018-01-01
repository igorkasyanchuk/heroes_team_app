class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  layout :layout_by_resource

  def current_tenant
    current_user&.tenant
  end

  def authorize_admin!
    redirect_to(root_path) unless current_user&.role == User::ADMIN_ROLE
  end

  def layout_by_resource
    if devise_controller? && resource_name == :user && action_name == 'new'
      "landing"
    else
      "application"
    end
  end
end
