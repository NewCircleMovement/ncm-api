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

require 'rails_helper'

RSpec.describe Yield, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
