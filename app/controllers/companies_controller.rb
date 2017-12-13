class CompaniesController < ApplicationController
  def index
    @companies = Company.all
  end

  def show
    current_company
  end

  def new
    @company = Company.new
  end

  def create
    @company = Company.new(company_params)
    if @company.save
      redirect_to companies_path
    else
      render 'new'
    end
  end

  def edit
    current_company
  end

  def update
    current_company
    if @company.update_attributes(company_params)
      redirect_to @company
    else
      render 'edit'
    end
  end

  def destroy
    current_company.destroy
  end

  private

  def company_params
    params.require(:company).permit(:name, :domain)
  end

  def current_company
    @company = Company.find(params[:id])
  end
end
