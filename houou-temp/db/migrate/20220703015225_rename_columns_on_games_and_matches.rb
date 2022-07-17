class RenameColumnsOnGamesAndMatches < ActiveRecord::Migration[7.0]
  def change
    rename_column :games, :mahjong_match_id, :match_id
    rename_column :matches, :mahjong_jansou_id, :jansou_id
  end
end
