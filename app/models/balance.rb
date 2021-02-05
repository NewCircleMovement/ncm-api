# == Schema Information
#
# Table name: balances
#
#  id          :bigint(8)        not null, primary key
#  holder_id   :integer
#  holder_type :string
#  owner_id    :integer
#  owner_type  :string
#  fruit_id    :integer
#  amount      :float            default(0.0)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Balance < ApplicationRecord
  """ A balance shows an epicenter's current holdings of a particular fruit """
  
  include BetweenDates
  
  belongs_to :holder, :polymorphic => true
  belongs_to :fruit


  def self.update_holder_balance(fruit_id, holder_id, holder_type, amount, give=false)
    balance = Balance.find_or_initialize_by(fruit_id: fruit.id, holder_id: holder_id, holder_type: holder_type)
    if balance.new_record?
      fruit = Fruit.find(fruit_id)
      balance.owner_id = fruit.owner.nil? ? nil : f.owner.id
      balance.owner_type = fruit.owner.nil? ? 'Society' : f.owner.type
    end
    if give
      balance.amount -= amount
    else
      balance.amount += amount
    end
    balance.save
  end

end
