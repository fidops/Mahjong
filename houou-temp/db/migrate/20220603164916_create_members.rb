class CreateMembers < ActiveRecord::Migration[7.0]
  def change
    enable_extension 'pgcrypto' unless extension_enabled?('pgcrypto')

    create_table :members, id: :uuid do |t|
      t.string :name
      t.string :discord_id

      t.timestamps
    end
  end
end
