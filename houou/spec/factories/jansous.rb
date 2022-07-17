# == Schema Information
#
# Table name: jansous
#
#  id             :uuid             not null, primary key
#  address        :string
#  google_map_url :string
#  name           :string
#  note           :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
FactoryBot.define do
  factory :jansou do
    name { Faker::Name.name }
    google_map_url { Faker::Internet.url }
    address { Faker::Address.full_address }
    note { '601' }
  end
end
