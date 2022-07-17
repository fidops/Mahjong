class CreateMahjongJansous < ActiveRecord::Migration[7.0]
  def change
    enable_extension 'pgcrypto' unless extension_enabled?('pgcrypto')

    create_table :mahjong_jansous, id: :uuid do |t|
      t.string :name
      t.string :google_map_url
      t.string :address
      t.string :note

      t.timestamps
    end
  end
end
