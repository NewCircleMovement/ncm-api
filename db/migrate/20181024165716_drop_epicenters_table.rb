class DropEpicentersTable < ActiveRecord::Migration[5.2]
  def change
    drop_table :epicenters do |t|
      t.string :type
      t.integer :parent_id
      t.integer :level
      t.string :slug
      t.string :name
      t.string :description

      t.timestamps null: false
      t.index :slug, unique: true
    end
  end
end
