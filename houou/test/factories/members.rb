FactoryBot.define do
  factory :member do
    id { Faker::Internet.uuid }
    name { Faker::Name.name }
    discord_id { Faker::Number.number(digits: 18).to_s }
  end
end
