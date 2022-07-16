FactoryBot.define do
  factory :mahjong_jansou do
    name { Faker::Name.name }
    google_map_url { Faker::Internet.url }
    address { Faker::Address.full_address }
    note { '601' }
  end
end
