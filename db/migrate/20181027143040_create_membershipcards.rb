class CreateMembershipcards < ActiveRecord::Migration[5.2]
  def change
    create_table :membershipcards do |t|
      t.integer :membership_id
      t.integer :owner_id
      t.string :owner_type
      t.integer :epicenter_id
      t.string :epicenter_type
      t.boolean :active, :default => true
      t.string :payment_id

      t.timestamps
    end

    # which membership are we talking about
    add_index :membershipcards, :membership_id

    # of which epicenter is the membership about
    add_index :membershipcards, [:epicenter_id, :epicenter_type]

    # to whom does the membership belong
    add_index :membershipcards, [:owner_id, :owner_type]
    
  end
end
