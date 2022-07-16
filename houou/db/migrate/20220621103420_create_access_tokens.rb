class CreateAccessTokens < ActiveRecord::Migration[7.0]
  def change
    create_table :access_tokens do |t|
      t.string :token, index: { unique: true }
      t.string :auth_token, index: { unique: true }

      t.timestamps
    end
  end
end
