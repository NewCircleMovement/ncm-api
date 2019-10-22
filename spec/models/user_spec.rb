# == Schema Information
#
# Table name: users
#
#  id         :bigint(8)        not null, primary key
#  slug       :string
#  name       :string
#  data       :jsonb
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe User, type: :model do

  it "is valid with valid attributes" do
    params = { name: 'Egon Olsen', slug: 'egon_olsen' }
    event = User.new(params)
    expect(event).to be_valid
  end

end
