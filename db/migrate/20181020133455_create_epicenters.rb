class CreateEpicenters < ActiveRecord::Migration[5.2]
  def change
    create_table :epicenters do |t|
      t.string :type
      t.integer :parent_id
      t.integer :level
      t.string :slug
      t.string :name
      t.string :description

      t.timestamps
    end
  end
end
