class ChangeOwnerTypeToBeStringInEvents < ActiveRecord::Migration[5.2]
  def change
    change_column :events, :owner_type, :string
  end
end
