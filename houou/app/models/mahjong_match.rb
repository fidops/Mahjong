class MahjongMatch < ApplicationRecord
  has_many :mahjong_games, dependent: :destroy
  belongs_to :mahjong_jansou
end
