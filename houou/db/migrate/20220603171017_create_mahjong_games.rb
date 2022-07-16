class CreateMahjongGames < ActiveRecord::Migration[7.0]
  def change
    create_table :mahjong_games do |t|
      t.belongs_to :east,  null: false, foreign_key: { to_table: :members }, type: :uuid
      t.belongs_to :south, null: false, foreign_key: { to_table: :members }, type: :uuid
      t.belongs_to :west,  null: false, foreign_key: { to_table: :members }, type: :uuid
      t.belongs_to :north, null: true,  foreign_key: { to_table: :members }, type: :uuid
      t.integer :east_score,  null: false
      t.integer :south_score, null: false
      t.integer :west_score,  null: false
      t.integer :north_score, null: true
      t.belongs_to :mahjong_match, null: false, foreign_key: true

      t.timestamps
    end
  end
end
