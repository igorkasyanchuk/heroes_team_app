FactoryBot.define do
  factory :company do
    name { Faker::Company.name }
    domain { Faker::Internet.domain_name }

    trait :invalid_domain do
      domain { Faker::Internet.email }
    end
  end
end
