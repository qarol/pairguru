FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    phone_number { "48 999-888-777" }
    name { Faker::Name.name }
    password { "password" }
    password_confirmation { "password" }

    trait :confirmed do
      confirmed_at { Faker::Time.backward(14, :evening) }
    end
  end
end
