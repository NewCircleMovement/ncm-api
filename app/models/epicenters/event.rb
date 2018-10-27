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
#  owner_type   :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Event < Epicenter
  belongs_to :mother, :class_name => "Tribe", :foreign_key => 'mother_id'

  belongs_to :owner, :polymorphic => true
  belongs_to :caretaker, :class_name => "User", :foreign_key => 'id'
end 
