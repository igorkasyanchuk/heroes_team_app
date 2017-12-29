class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def current_tenant
    current_user&.tenant
  end
end
