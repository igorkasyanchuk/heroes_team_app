class FullContactCompanyProcessor
  
  attr_accessor :company

  def initialize(company)
      @company = company
  end

  def add_information
    FullContact.api_key = 'mA89bZt0uRfvrWX06QjqLUfZOQNS87Lf'
    @response = FullContact.company(domain: @company.domain).to_hash
    
    #links
    @company.twitter = find_url('twitter')
    @company.facebook = find_url('facebook')
    @company.linkedin = find_url('linkedincompany')
    @company.youtube = find_url('youtube')
    @company.angellist = find_url('angellist')
    @company.owler = find_url('owler')
    @company.crunchbasecompany = find_url('crunchbasecompany')
    @company.pinterest = find_url('pinterest')
    @company.google = find_url('google')
    @company.klout = find_url('klout')

    #data from organization 
    organization = @response['organization']

    @company.name = organization['name']
    @company.approx_employees = organization['approx_employees']
    @company.founded = organization['founded']
    @company.overview = organization['overview']

    #data from industries
    set_industries
    @company
  end

  private

  def find_url(type_id)
    @response['social_profiles'].any? {|h| h['type_id'] == type_id} ?
        @response['social_profiles'].find {|x| x['type_id'] == type_id}['url'] : ''
  end

  def set_industries
    @response["industries"].each do |item|
      @company.industries << Industry.find_or_create_by(name: item["name"])
    end
  end
end