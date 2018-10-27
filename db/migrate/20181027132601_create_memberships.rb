class CreateMemberships < ActiveRecord::Migration[5.2]
  def change
    create_table :memberships do |t|
      t.integer :owner_id
      t.string :owner_type
      t.string :name
      t.text :description
      t.integer :fee
      t.integer :gain
      t.string :rhythm

      t.timestamps
    end

    add_index :memberships, [:owner_id, :owner_type]
    add_index :movements, :slug, unique: true
    add_index :tribes, :slug, unique: true
    
  end
end
