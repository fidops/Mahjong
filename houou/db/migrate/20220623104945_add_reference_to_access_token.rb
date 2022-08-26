class AddReferenceToAccessToken < ActiveRecord::Migration[7.0]
  def change
    add_reference :access_tokens, :administrator, null: false, foreign_key: true, type: :uuid
  end
end
