# == Schema Information
#
# Table name: matches
#
#  id         :uuid             not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  jansou_id  :uuid             not null
#
# Indexes
#
#  index_matches_on_jansou_id  (jansou_id)
#
# Foreign Keys
#
#  fk_rails_...  (jansou_id => jansous.id)
#
FactoryBot.define do
  factory :match do
    name { Faker::Restaurant.name }
    jansou { association :jansou }
  end
end
