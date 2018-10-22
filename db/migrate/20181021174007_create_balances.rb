class CreateBalances < ActiveRecord::Migration[5.2]
  def change
    create_table :balances do |t|
      t.integer :holder_id
      t.string :holder_type
      t.integer :owner_id
      t.string :owner_type
      t.integer :fruit_id
      t.float :amount

      t.timestamps
    end

    add_index :balances, [:holder_id, :holder_type]
    add_index :balances, [:owner_id, :owner_type]
    add_index :balances, :fruit_id
    add_index :balances, :updated_at
  end
end
