class Company < ApplicationRecord
  # VALID_DOMAIN_REGEX = /\A[a-z0-9-_]+\.+[_a-z0-9-\/]+\z/i # or "/\A[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}\z/ix"

  # belongs_to :user
  # has_many :page, dependent: :destroy


  validates :name, presence: true, length: { maximum: 64 }
  validates :domain, presence: true, length: { minimum: 3, maximum: 64 },
  #           format: { with: VALID_DOMAIN_REGEX },
            uniqueness: { case_sensitive: false }

end
