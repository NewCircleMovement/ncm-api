# == Schema Information
#
# Table name: fruit_balances
#
#  id          :bigint(8)        not null, primary key
#  holder_id   :integer
#  holder_type :string
#  owner_id    :integer
#  owner_type  :string
#  fruit_id    :integer
#  amount      :float
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Balance < ApplicationRecord
end
