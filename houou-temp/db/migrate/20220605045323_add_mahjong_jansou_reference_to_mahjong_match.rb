class AddMahjongJansouReferenceToMahjongMatch < ActiveRecord::Migration[7.0]
  def change
    enable_extension 'pgcrypto' unless extension_enabled?('pgcrypto')
    add_reference :mahjong_matches, :mahjong_jansou, null: false, foreign_key: true, type: :uuid
  end
end
