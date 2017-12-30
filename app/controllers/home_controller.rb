class HomeController < ApplicationController
  def index
    redirect_to account_root_path if user_signed_in?
  end
end
