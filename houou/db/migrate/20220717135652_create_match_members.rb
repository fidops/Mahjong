class CreateMatchMembers < ActiveRecord::Migration[7.0]
  def change
    enable_extension 'pgcrypto' unless extension_enabled?('pgcrypto')
    create_table :match_members, id: :uuid do |t|
      t.references :match, null: false, foreign_key: true, type: :uuid
      t.references :member, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
