class CompaniesController < ApplicationController
  before_action :authenticate_user!

  def index
    @companies = Company.all
  end

  def show
    @company = current_company
  end

  def new
    @company = Company.new
  end

  def create
    @company = current_user.companies.build(company_params)
    full_contact
    if @company.save
      redirect_to companies_path
    else
      render :new
    end
  end

  def edit
    @company = current_company
  end

  def update
    @company = current_company
    full_contact
    if @company.update_attributes(company_params)
      redirect_to company_path
    else
      render :edit
    end
  end

  def destroy
    @company = current_company
    @company.destroy
    redirect_to companies_path
  end

  private

  def company_params
    params.require(:company).permit(:name, :domain)
  end

  def current_company
    Company.find(params[:id])
  end

  def full_contact
    FullContact.api_key = 'mA89bZt0uRfvrWX06QjqLUfZOQNS87Lf'
    @response = FullContact.company(domain: @company.domain).to_hash
    
    #links
    @company.twitter = find_url 'twitter'
    @company.facebook = find_url 'facebook'
    @company.linkedin = find_url 'linkedincompany'
    @company.youtube = find_url 'youtube'
    #add new
    @company.angellist = find_url 'angellist'
    @company.owler = find_url 'owler'
    @company.crunchbasecompany = find_url 'crunchbasecompany'
    @company.pinterest = find_url 'pinterest'
    @company.google = find_url 'google'
    @company.klout = find_url 'klout'

    #data from organization 
    organization = @response['organization']

    @company.name = organization['name']
    @company.approx_employees = organization['approx_employees']
    @company.founded = organization['founded']
    @company.overview = organization['overview']

    #data from industries
    set_industries
  end

  def find_url type_id
    @response['social_profiles'].any? {|h| h['type_id'] == type_id} ?
        @response['social_profiles'].find {|x| x['type_id'] == type_id}['url'] : ''
  end
  def set_industries
    @response["industries"].each do |item|
      @company.industries << Industry.find_or_create_by(name: item["name"])
    end
  end
end
