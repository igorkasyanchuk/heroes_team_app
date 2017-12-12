require 'rails_helper'

RSpec.describe Company, type: :model do
  it { should validate_presence_of(:name) }
  it { should validate_length_of(:name).is_at_least(2) }
  it { should validate_length_of(:name).is_at_most(64) }

  it { should validate_presence_of(:domain) }
  it { should validate_length_of(:domain).is_at_least(3) }
  it { should validate_length_of(:domain).is_at_most(64) }

  it { should allow_value(Faker::Internet.domain_name).for(:domain) }
end
