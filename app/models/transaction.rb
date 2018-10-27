# == Schema Information
#
# Table name: transactions
#
#  id            :bigint(8)        not null, primary key
#  giver_id      :integer
#  giver_type    :string
#  receiver_id   :integer
#  receiver_type :string
#  fruit_id      :integer
#  amount        :float
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Transaction < ApplicationRecord
  belongs_to :giver, :polymorphic => true
  belongs_to :receiver, :polymorphic => true
  belongs_to :fruit

  after_create :update_balances

  def update_balances
    f = Fruit.find(self.fruit_id)
    f_owner_id = f.owner.nil? ? nil : f.owner.id
    f_owner_type = f.owner.nil? ? 'Society' : f.owner.type

    
    giver_balance = Balance.find_or_initialize_by(:holder_id => self.giver_id, :holder_type => self.giver_type, :fruit_id => self.fruit_id)
    if giver_balance.new_record?
      giver_balance.owner_id = f_owner_id
      giver_balance.owner_type = f_owner_type
    end
    giver_balance.amount -= self.amount
    giver_balance.save

    receiver_balance = Balance.find_or_initialize_by(:holder_id => self.receiver_id, :holder_type => self.receiver_type, :fruit_id => self.fruit_id)
    if receiver_balance.new_record?
      giver_balance.owner_id = f_owner_id
      giver_balance.owner_type = f_owner_type
    end
    receiver_balance.amount += self.amount
    receiver_balance.save
  end

end
