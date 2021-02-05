# == Schema Information
#
# Table name: yields
#
#  id            :bigint(8)        not null, primary key
#  fruit_id      :integer
#  receiver_id   :integer
#  receiver_type :string
#  amount        :float
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Yield < ApplicationRecord
  """ 
  Every epicenter receives yields of fruit according to their membership 
  Yield recrords are stored as single entities for each fruit yield for each epicenter
  """

  include BetweenDates

  belongs_to :fruit
  belongs_to :receiver, :polymorphic => true

  after_create :update_fruit_balance


  def self.yield_fruit(fruit_id, receiver_id, receiver_type, fruit_yield)
    yield_record = {
      :fruit_id => fruit_id,
      :receiver_id => receiver_id, :receiver_type => receiver_type,
      :amount => fruit_yield
    }
    return Yield.create(yield_record)
  end


  def update_fruit_balance
    # the balance of the fruit yield recipient must be updated """
    Balance.update_holder_balance(self.fruit_id, self.receiver_id, self.receiver_type, self.amount)
  end

end
