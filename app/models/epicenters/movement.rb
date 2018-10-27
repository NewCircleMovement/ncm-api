# == Schema Information
#
# Table name: movements
#
#  id         :bigint(8)        not null, primary key
#  mother_id  :integer          default(0)
#  slug       :string
#  name       :string
#  data       :jsonb
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Movement < Epicenter
  belongs_to :mother, :class_name => "Movement"
  has_many :movements, :class_name => "Movement", :foreign_key => 'mother_id'
  has_many :tribes, :class_name => "Tribe", :foreign_key => 'mother_id'

  # a movement can be member of other epicenters
  has_many :movement_members, through: :membershipcards, source: :owner, source_type: 'Movement'
  has_many :tribe_members, through: :membershipcards, source: :owner, source_type: 'Tribe'
  has_many :user_members, through: :membershipcards, source: :owner, source_type: 'User'
  
  # has_many :members, as: :membershipcards, dependent: :destroy
  # has_many :users, through: :members

end
