class CreateFruits < ActiveRecord::Migration[5.2]
  def change
    create_table :fruits do |t|
      t.string :name
      t.integer :owner_id
      t.string :owner_type
      t.float :monthly_decay

      t.timestamps
    end

    add_index :fruits, [:owner_id, :owner_type]
  end
end
