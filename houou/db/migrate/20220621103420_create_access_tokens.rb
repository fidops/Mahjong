class CreateAccessTokens < ActiveRecord::Migration[7.0]
  def change
    enable_extension 'pgcrypto' unless extension_enabled?('pgcrypto')

    create_table :access_tokens, id: :uuid do |t|
      t.string :token, index: { unique: true }
      t.string :auth_token, index: { unique: true }

      t.timestamps
    end
  end
end
