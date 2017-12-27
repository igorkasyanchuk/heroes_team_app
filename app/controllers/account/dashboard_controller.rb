class Account::DashboardController < ApplicationController
  before_action :authenticate_user!

  def index
    render layout: 'dashboard'
  end

  private

  def user_admin?
    current_user.role.eql? "admin"
  end
end
