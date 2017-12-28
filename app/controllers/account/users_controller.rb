class Account::UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = current_tenant_users.page(params[:page]).per(10)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    set_tenant_id
    set_default_password
    if @user.save
      flash[:success] = "New user is successfuly created!"
      redirect_to account_users_path
    else
      flash[:danger] = "Your new user has invalid data!"
      render :new
    end
  end

  def edit
    @user = set_current_tenant_user
  end

  def update
    @user = set_current_tenant_user
    if @user.update_attributes(user_params)
      flash[:success] = "Successfuly updated!"
      redirect_to account_users_path
    else
      flash[:danger] = "Failed to update!"
      render :edit
    end
  end

  def destroy
    @user = set_current_tenant_user
    @user.destroy
    flash[:success] = "User deleted!"
    redirect_to account_users_path
  end

  private

  def set_default_password
    @user.password = User::DEFAULT_PASSWORD
  end

  def set_tenant_id
    @user.tenant = current_tenant
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password,
                                 :role, :tenant_id)
  end

  def current_tenant
    current_user.tenant
  end

  def current_tenant_users
    User.where(tenant_id: current_tenant).order(created_at: :asc)
  end

  def set_current_tenant_user
    User.find(params[:id])
  end
end
