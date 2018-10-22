class SetDefaultBalancesValue < ActiveRecord::Migration[5.2]
  def change
    change_column :balances, :amount, :float, :default => 0
  end
end
