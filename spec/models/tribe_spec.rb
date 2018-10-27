# == Schema Information
#
# Table name: tribes
#
#  id         :bigint(8)        not null, primary key
#  mother_id  :integer          default(0)
#  slug       :string
#  name       :string
#  data       :jsonb
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe Tribe, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
