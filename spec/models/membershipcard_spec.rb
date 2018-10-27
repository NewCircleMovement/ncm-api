# == Schema Information
#
# Table name: membershipcards
#
#  id             :bigint(8)        not null, primary key
#  membership_id  :integer
#  owner_id       :integer
#  owner_type     :string
#  epicenter_id   :integer
#  epicenter_type :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

require 'rails_helper'

RSpec.describe Membershipcard, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
