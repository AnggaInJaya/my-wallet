class CreateWallets < ActiveRecord::Migration[8.0]
  def change
    create_table :wallets do |t|
      t.integer :entityable_id
      t.string :entityable_type
      t.integer :balance

      t.timestamps
    end
  end
end
