class CreateTribes < ActiveRecord::Migration[5.2]
  def change
    create_table :tribes do |t|
      t.integer :mother_id, :default => 0
      t.string :slug
      t.string :name
      t.jsonb :data

      t.timestamps
    end
  end
end
