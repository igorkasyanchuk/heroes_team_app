class User < ApplicationRecord
  SALE_ROLE = 'sale'.freeze
  ADMIN_ROLE = 'admin'.freeze
  MODERATOR_ROLE = 'moderator'.freeze
  ROLES = [SALE_ROLE, ADMIN_ROLE, MODERATOR_ROLE].freeze
  DEFAULT_PASSWORD = 'password'.freeze

  has_many :companies, dependent: :destroy
  belongs_to :tenant, optional: true

  accepts_nested_attributes_for :tenant

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :first_name, length: { minimum: 3, maximum: 50 }, presence: true
  validates :last_name,  length: { minimum: 3, maximum: 50 }, presence: true
  validates :tenant, presence: true

  def full_name
    [first_name, last_name].reject(&:blank?).join(' ')
  end

  def admin?
    self&.role == ADMIN_ROLE
  end

  def sales?
    self&.role == SALE_ROLE
  end

  def moderator?
    self&.role == MODERATOR_ROLE
  end

  def self.roles_for_select
    [SALE_ROLE, ADMIN_ROLE]
  end
end
