class FullContactCompanyProcessor
  def initialize(company:)
    @company = company
  end

  def process
    return if response.blank? || response['status'] != 200
    fill_data
    @company.save
    @company
  end

  private

  def links
    @links = response['social_profiles']
  end

  def response
    @response = call_fullcontact_api
  end

  def fill_data
    process_links
    process_organization
    set_industries
  end

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
    organization = response['organization']
    @company.name = organization['name']
    @company.approx_employees = organization['approx_employees']
    @company.founded = organization['founded']
    @company.overview = organization['overview']
  end

  def call_fullcontact_api
    FullContact.company(domain: @company.domain).to_hash
  rescue FullContact::NotFound, FullContact::Invalid, FullContact::Forbidden
    nil
  end

  def find_url(type_id)
    return unless !links.blank? && links.any? { |link| link['type_id'] == type_id }
    links.find { |item| item['type_id'] == type_id }['url']
  end

  def set_industries
    all_industry = response['industries']
    return unless all_industry
    all_industry.each do |item|
      @company.industries << Industry.find_or_create_by(name: item['name'])
    end
  end
end
