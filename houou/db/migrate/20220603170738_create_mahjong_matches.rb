class CreateMahjongMatches < ActiveRecord::Migration[7.0]
  def change
    create_table :mahjong_matches do |t|
      t.string :name

      t.timestamps
    end
  end
end
