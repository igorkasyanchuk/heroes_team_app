class Industry < ApplicationRecord
  has_and_belongs_to_many :companies
  scope :ordered_by_name, -> { order(name: :asc) }
  validates :name, presence: true
end
