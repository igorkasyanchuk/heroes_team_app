class FullContactCompanyProcessor
  def initialize(company:)
    @company = company
  end

  def process
    @response = call_fullcontact_api
    return if @response.nil? || @response['status'] != 200
    process_links
    process_organization
    set_industries
    @company.save
    @company
  end

  private

  def process_links
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
  end

  def process_organization
    organization = @response['organization']
    @company.name = organization['name'] || ''
    @company.approx_employees = organization['approx_employees'] || ''
    @company.founded = organization['founded'] || ''
    @company.overview = organization['overview'] || ''
  end

  def call_fullcontact_api
    FullContact.api_key = Rails.application.secrets.fullcontact_api_key
    FullContact.company(domain: @company.domain).to_hash
  rescue FullContact::NotFound, FullContact::Invalid
    nil
  end

  def find_url(type_id)
    if @response['social_profiles']&.any? { |h| h['type_id'] == type_id }
      @response['social_profiles'].find { |x| x['type_id'] == type_id }['url']
    else
      ''
    end
  end

  def set_industries
    return unless @response['industries']
    @response['industries'].each do |item|
      @company.industries << Industry.find_or_create_by(name: item['name'])
    end
  end
end
