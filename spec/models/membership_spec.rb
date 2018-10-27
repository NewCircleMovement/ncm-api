# == Schema Information
#
# Table name: memberships
#
#  id          :bigint(8)        not null, primary key
#  owner_id    :integer
#  owner_type  :string
#  name        :string
#  description :text
#  fee         :integer
#  gain        :integer
#  rhythm      :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'rails_helper'

RSpec.describe Membership, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
