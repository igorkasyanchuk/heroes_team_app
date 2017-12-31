require 'validates_email_format_of'

class User < ApplicationRecord
  SALE_ROLE = 'sale'.freeze
  ADMIN_ROLE = 'admin'.freeze
  MODERATOR_ROLE = 'moderator'.freeze
  ROLES = [SALE_ROLE, ADMIN_ROLE, MODERATOR_ROLE].freeze

  has_many :companies, dependent: :destroy
  belongs_to :tenant, optional: true

  accepts_nested_attributes_for :tenant

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :first_name, length: { minimum: 3, maximum: 50 }, presence: true
  validates :last_name,  length: { minimum: 3, maximum: 50 }, presence: true
  validates :tenant, presence: true
  validates :phone, length: { maximum: 32 }, allow_blank: true
  validates :email, presence: true, uniqueness: true, email_format: { message: 'has invalid format' }

  def full_name
    [first_name, last_name].reject(&:blank?).join('')
  end
end
