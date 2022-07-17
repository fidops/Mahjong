class CreateAdministrators < ActiveRecord::Migration[7.0]
  def change
    enable_extension 'pgcrypto' unless extension_enabled?('pgcrypto')
    create_table :administrators, id: :uuid do |t|
      t.string :userid
      t.string :password_digest

      t.timestamps
    end
  end
end
