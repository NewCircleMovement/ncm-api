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
  belongs_to :owner, polymorphic: true

  validates :name, :presence => true
  validates :monthly_decay, :presence => true, 
    :numericality => { only_float: true, greater_than: 0.01 }, 
    :inclusion => { in: 0..1 }

  has_many :balances
  has_many :transactions
  
end
