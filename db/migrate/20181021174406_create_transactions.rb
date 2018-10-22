class CreateTransactions < ActiveRecord::Migration[5.2]
  def change
    create_table :transactions do |t|
      t.integer :giver_id
      t.string :giver_type
      t.integer :receiver_id
      t.string :receiver_type
      t.integer :fruit_id
      t.float :amount

      t.timestamps
    end

    add_index :transactions, [:giver_id, :giver_type]
    add_index :transactions, [:receiver_id, :receiver_type]
    add_index :transactions, :fruit_id
    add_index :transactions, :created_at

    add_index :epicenters, :slug
  end
end
