FactoryBot.define do
  factory :administrator do
    userid { Faker::Internet.username }
    password_digest { Faker::Internet.password }
  end
end
