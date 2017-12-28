class User < ApplicationRecord
  SALE_ROLE = 'sale'.freeze
  ADMIN_ROLE = 'admin'.freeze
  MODERATOR_ROLE = 'moderator'.freeze
  ROLES = [SALE_ROLE, ADMIN_ROLE, MODERATOR_ROLE].freeze
<<<<<<< HEAD
  DEFAULT_PASSWORD = 'password'.freeze
=======
  VALID_PHONE_REGEX = /\A[+]?[\d\-.() ]+\z/
  VALID_EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
>>>>>>> Added validation for user

  has_many :companies, dependent: :destroy
  belongs_to :tenant, optional: true

  accepts_nested_attributes_for :tenant

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :first_name, length: { minimum: 3, maximum: 50 }, presence: true
  validates :last_name,  length: { minimum: 3, maximum: 50 }, presence: true
  validates :tenant, presence: true
<<<<<<< HEAD
  validates :role, presence: true, inclusion: ROLES

  scope :by_date, -> { order(created_at: :asc) }

  delegate :name, to: :tenant, prefix: true, allow_nil: true
=======
  validates :phone, length: { maximum: 32 }, format: { with: VALID_PHONE_REGEX }, allow_blank: true
  validates :email, format: { with: VALID_EMAIL_REGEX }, allow_blank: true
>>>>>>> Added validation for user

  def full_name
    [first_name, last_name].reject(&:blank?).join(' ')
  end
end
