FactoryBot.define do
  factory :company do
    name {Faker::Company.name}

    trait :valid_domain do
      domain {Faker::Internet.domain_name}
    end

    trait :invalid_domain do
      domain {Faker::Internet.email}
    end

  end
end
