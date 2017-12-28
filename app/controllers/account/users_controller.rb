class Account::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :admin_user

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
    @user.tenant = current_tenant
    @user.password = User::DEFAULT_PASSWORD
    if @user.save
      flash[:success] = "New user is successfuly created!"
      redirect_to account_users_path
    else
      flash[:danger] = "Your new user has invalid data!"
      render :new
    end
  end

  def edit
    @user = resource
  end

  def update
    @user = resource
    if @user.update_attributes(resource_params)
      flash[:success] = "Successfuly updated!"
      redirect_to account_users_path
    else
      flash[:danger] = "Failed to update!"
      render :edit
    end
  end

  def destroy
    @user = resource
    @user.destroy
    flash[:success] = "User deleted!"
    redirect_to account_users_path
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
