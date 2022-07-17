# == Schema Information
#
# Table name: games
#
#  id          :uuid             not null, primary key
#  east_score  :integer          not null
#  north_score :integer
#  south_score :integer          not null
#  west_score  :integer          not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  east_id     :uuid             not null
#  match_id    :uuid             not null
#  north_id    :uuid
#  south_id    :uuid             not null
#  west_id     :uuid             not null
#
# Indexes
#
#  index_games_on_east_id   (east_id)
#  index_games_on_match_id  (match_id)
#  index_games_on_north_id  (north_id)
#  index_games_on_south_id  (south_id)
#  index_games_on_west_id   (west_id)
#
# Foreign Keys
#
#  fk_rails_...  (east_id => members.id)
#  fk_rails_...  (match_id => matches.id)
#  fk_rails_...  (north_id => members.id)
#  fk_rails_...  (south_id => members.id)
#  fk_rails_...  (west_id => members.id)
#
FactoryBot.define do
  factory :game do
    east  { association :member }
    south { association :member }
    west  { association :member }
    north { association :member }
    east_score  { Faker::Number.between(from: -10_000, to: 40_000) }
    south_score { Faker::Number.between(from: -10_000, to: 40_000) }
    west_score  { Faker::Number.between(from: -10_000, to: 40_000) }
    north_score { Faker::Number.between(from: -10_000, to: 40_000) }
    match { association :match }

    trait :sanma do
      north { nil }
      north_score { nil }
    end
  end
end
