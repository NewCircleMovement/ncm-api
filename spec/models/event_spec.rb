# == Schema Information
#
# Table name: events
#
#  id           :bigint(8)        not null, primary key
#  slug         :string
#  name         :string
#  data         :jsonb
#  caretaker_id :integer
#  owner_id     :integer
#  owner_type   :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  date         :date
#  time         :time
#

require 'rails_helper'

RSpec.describe Event, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
