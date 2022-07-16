FactoryBot.define do
  factory :mahjong_game do
    east  { association :member }
    south { association :member }
    west  { association :member }
    north { association :member }
    east_score  { Faker::Number.between(from: -10_000, to: 40_000) }
    south_score { Faker::Number.between(from: -10_000, to: 40_000) }
    west_score  { Faker::Number.between(from: -10_000, to: 40_000) }
    north_score { Faker::Number.between(from: -10_000, to: 40_000) }
    mahjong_match { association :mahjong_match }

    trait :sanma do
      north { nil }
      north_score { nil }
    end
  end
end
