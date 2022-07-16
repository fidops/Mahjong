class MahjongGame < ApplicationRecord
  belongs_to :east,  nil, class_name: 'Member'
  belongs_to :south, nil, class_name: 'Member'
  belongs_to :west,  nil, class_name: 'Member'
  belongs_to :north, nil, class_name: 'Member', optional: true
  belongs_to :mahjong_match
end
