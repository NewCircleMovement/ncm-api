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
require 'fixture_helper'

RSpec.describe Event, type: :model do
  # let(:events) { yaml_fixture_file("events.yml") }
  # let(:users) { yaml_fixture_file("users.yml") }

  before(:each) do
    Rails.application.load_seed
  end

  it "is invalid with empty attributes" do
    expect(Event.new).to be_invalid
  end

  it "is valid with valid attributes" do
    user = User.first
    params = { name: 'Test Event', slug: 'test_event', caretaker_id: 1, owner_type: 'User', owner_id: user.id }
    event = Event.new(params)
    expect(event).to be_valid
  end
end
