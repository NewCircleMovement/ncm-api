# == Schema Information
#
# Table name: fruits
#
#  id            :bigint(8)        not null, primary key
#  name          :string
#  owner_id      :integer
#  owner_type    :string
#  monthly_decay :float
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  monthly_yield :integer          default(100)
#

class Fruit < ApplicationRecord
  """ 
  Every epicenter has a fruit (actually we should really think about it as a fruit tree / blueprint)
  It yields fruit according to epicenter memberships
  And can be transacted between epicenters
  """

  belongs_to :owner, polymorphic: true

  validates :name, :presence => true
  validates :monthly_decay, :presence => true, 
    :numericality => { only_float: true, greater_than: 0.01 }, 
    :inclusion => { in: 0..1 }

  has_many :yields
  has_many :balances
  has_many :transactions

  
  def yield
    fruit_yields =  get_membership_yields()

    self.owner.active_cards.each do |card|
      fruit_yield = fruit_yields[card.membership_id]
      Yield.yield_fruit(fruit_id, card.owner_id, card.owner_type, fruit_yield)
    end
  end

  def get_membership_yields
    yields = {}
    self.owner.memberships.each do |membership|
      yields[membership.id] =  membership.gain
    end
    return yields
  end
  
end

