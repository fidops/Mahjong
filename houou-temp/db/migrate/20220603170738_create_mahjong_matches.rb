class CreateMahjongMatches < ActiveRecord::Migration[7.0]
  def change
    enable_extension 'pgcrypto' unless extension_enabled?('pgcrypto')

    create_table :mahjong_matches, id: :uuid do |t|
      t.string :name

      t.timestamps
    end
  end
end
