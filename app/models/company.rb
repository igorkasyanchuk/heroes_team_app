class Company < ApplicationRecord
  VALID_DOMAIN_REGEX = /\A[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,6}\z/ix

  belongs_to              :user
  has_and_belongs_to_many :industries
  # has_many :pages, dependent: :destroy

  validates :name, presence: true, length: { minimum: 2, maximum: 64 }
  validates :domain, presence: true, length: { minimum: 3, maximum: 64 },
                     format: { with: VALID_DOMAIN_REGEX }
end
