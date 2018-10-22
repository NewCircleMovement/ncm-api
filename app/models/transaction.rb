# == Schema Information
#
# Table name: fruit_transactions
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
  after_create :update_balances

  def update_balances
    giver_balance = Balance.find_or_create_by(:holder_id => self.giver_id, :fruit_id => self.fruit_id)
    giver_balance.amount -= self.amount
    giver_balance.save
    
    receiver_balance = Balance.find_or_create_by(:holder_id => self.receiver_id, :fruit_id => self.fruit_id)
    receiver_balance.amount += self.amount
    receiver_balance.save
  end

end
