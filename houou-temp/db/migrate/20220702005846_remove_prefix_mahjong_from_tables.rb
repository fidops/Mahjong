class RemovePrefixMahjongFromTables < ActiveRecord::Migration[7.0]
  def change
    rename_table :mahjong_games, :games
    rename_table :mahjong_jansous, :jansous
    rename_table :mahjong_matches, :matches
  end
end
