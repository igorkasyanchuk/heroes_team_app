class Account::DashboardController < ApplicationController
  before_action :authenticate_user!

  def index
    render layout: 'dashboard'
  end
end
