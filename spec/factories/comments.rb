FactoryBot.define do
  factory :comment do
    user
    movie
    content { Faker::Lorem.paragraph }
  end
end
