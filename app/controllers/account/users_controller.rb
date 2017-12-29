class Account::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :require_admin!

  def index
    @users = collection.page(params[:page]).per(10)
  end

  def show
    @user = resource
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(resource_params)
    @user.assign_attributes(tenant: current_tenant, password: User::DEFAULT_PASSWORD)
    if @user.save
      redirect_to account_users_path, success: 'New user is successfuly created!'
    else
      render :new, danger: 'Your new user has invalid data!'
    end
  end

  def edit
    @user = resource
  end

  def update
    @user = resource
    if @user.update_attributes(resource_params)
      redirect_to account_users_path, success: 'Successfuly updated!'
    else
      render :edit, danger: 'Failed to update!'
    end
  end

  def destroy
    @user = resource
    @user.destroy
    redirect_to account_users_path, success: 'User deleted!'
  end

  private

  def resource_params
    params.require(:user).permit(:first_name, :last_name, :email, :password,
                                 :role, :tenant_id)
  end

  def collection
    current_tenant.users.order(created_at: :asc)
  end

  def resource
    collection.find(params[:id])
  end
end
