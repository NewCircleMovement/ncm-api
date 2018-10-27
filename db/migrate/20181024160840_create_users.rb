class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :slug
      t.string :name
      t.jsonb :data

      t.timestamps
    end
  end
end
