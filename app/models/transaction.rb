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
  """ 
  A transaction record is created every time fruit changes hands between epicenters 
  After each transaction, the balances of the two epictners are updated
  """

  belongs_to :giver, :polymorphic => true
  belongs_to :receiver, :polymorphic => true
  belongs_to :fruit

  after_create :update_fruit_balances


  def self.make_fruit_transaction(fruit_id, amount, giver={}, receiver={})
    unless giver.values_at(:id, :type).all? and receiver.values_at(:id, :type).all? #=> true
      raise ArgumentError
    end

    # transaction_record = {
    #   fruit_id: fruit_id, amount: amount,
    #   giver_id: giver[:id], giver_type: giver[:type],
    #   receiver_id: receiver[:id], receiver_type: receiver[:type],
    # }
    # return Transaction.create(transaction_record)
  end


  def update_fruti_balances
    # giver
    Balance.update_holder_balance(self.fruit_id, self.giver_id, self.giver_type, amount, give=true)
    
    # receiver
    Balance.update_holder_balance(self.fruit_id, self.receiver_id, self.receiver_type, amount)
  end

end
