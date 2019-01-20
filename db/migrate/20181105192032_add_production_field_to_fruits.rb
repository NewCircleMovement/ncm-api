class AddProductionFieldToFruits < ActiveRecord::Migration[5.2]
  def change
    add_column :fruits, :monthly_yield, :integer, :default => 100
  end
end
