class Company < ApplicationRecord
  VALID_DOMAIN_REGEX = /\A[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,6}\z/ix

  belongs_to :user
  has_many :pages, dependent: :destroy
  has_and_belongs_to_many :industries, -> { distinct }
  validates :name, presence: true, length: { minimum: 3, maximum: 64 }
  validates :domain, presence: true, length: { minimum: 3, maximum: 64 },
                     format: { with: VALID_DOMAIN_REGEX }
  after_create :populate_fullcontact_data

  private

  def populate_fullcontact_data
    FullContactCompanyProcessor.new(company: self).process
  end
end
