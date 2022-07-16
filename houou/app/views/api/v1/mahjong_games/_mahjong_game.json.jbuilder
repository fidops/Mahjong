json.extract! mahjong_game, :id, :east_id, :south_id, :west_id, :north_id,
              :east_score, :south_score, :west_score, :north_score,
              :mahjong_match_id, :created_at, :updated_at
json.url api_v1_mahjong_game_url(mahjong_game, format: :json)
