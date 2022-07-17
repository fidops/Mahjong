# == Schema Information
#
# Table name: members
#
#  id         :uuid             not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  discord_id :string
#
FactoryBot.define do
  factory :member do
    id { Faker::Internet.uuid }
    name { Faker::Name.name }
    discord_id { Faker::Number.number(digits: 18).to_s }
  end
end
