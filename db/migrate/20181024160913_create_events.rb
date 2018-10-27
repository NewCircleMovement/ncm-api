class CreateEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|
      t.string :slug
      t.string :name
      t.jsonb :data
      t.integer :caretaker_id
      t.integer :owner_id
      t.integer :owner_type

      t.timestamps
    end

    add_index :events, :caretaker_id
    add_index :events, [:owner_id, :owner_type]
  end
end
