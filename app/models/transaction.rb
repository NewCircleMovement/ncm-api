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
end
