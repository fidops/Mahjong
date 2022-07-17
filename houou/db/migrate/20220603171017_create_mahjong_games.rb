class CreateMahjongGames < ActiveRecord::Migration[7.0]
  def change
    enable_extension 'pgcrypto' unless extension_enabled?('pgcrypto')

    create_table :mahjong_games, id: :uuid do |t|
      t.belongs_to :east,  null: false, foreign_key: { to_table: :members }, type: :uuid
      t.belongs_to :south, null: false, foreign_key: { to_table: :members }, type: :uuid
      t.belongs_to :west,  null: false, foreign_key: { to_table: :members }, type: :uuid
      t.belongs_to :north, null: true,  foreign_key: { to_table: :members }, type: :uuid
      t.integer :east_score,  null: false
      t.integer :south_score, null: false
      t.integer :west_score,  null: false
      t.integer :north_score, null: true
      t.belongs_to :mahjong_match, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
