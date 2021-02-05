class CreateYields < ActiveRecord::Migration[5.2]
  def change
    create_table :yields do |t|
      t.integer :fruit_id
      t.integer :receiver_id
      t.string :receiver_type
      t.float :amount

      t.timestamps
    end

    add_index :yields, :fruit_id
    add_index :yields, [:receiver_id, :receiver_type]
    add_index :yields, :created_at
  end
end
