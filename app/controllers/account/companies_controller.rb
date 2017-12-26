require 'bing_api'

class Account::CompaniesController < ApplicationController
  before_action :authenticate_user!
  #after_action Bing_api_v7::bing_pages_to_model(current_company.id), only: :create, if: -> { true }

  def index
    @companies = current_user.companies.all.page(params[:page]).per(4)
  end

  def show
    @company = current_company
  end

  def new
    @company = Company.new
  end

  def create
    @company = current_user.companies.build(company_params)
    if @company.save
      BingApiV7.new.bing_pages_to_model(@company.id)
      flash[:success] = "Company successfully created"
      redirect_to account_company_path(@company)
    else
      render :new
    end
  end

  def edit
    @company = current_company
  end

  def update
    @company = current_company
    if @company.update_attributes(company_params)
      flash[:success] = "Company updated"
      redirect_to account_company_path
    else
      render :edit
    end
  end

  def destroy
    @company = current_company
    @company.destroy
    flash[:success] = "Company deleted"
    redirect_to account_companies_path
  end

  private

  def company_params
    params.require(:company).permit(:name, :domain)
  end

  def current_company
    current_user.companies.find(params[:id])
  end
end