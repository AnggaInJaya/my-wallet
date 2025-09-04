class CreateRefreshTokens < ActiveRecord::Migration[8.0]
  def change
    create_table :refresh_tokens, id: false do |t|
      t.string :crypted_token, primary_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
    add_index :refresh_tokens, :crypted_token, unique: true
  end
end
