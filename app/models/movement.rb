class Movement < ApplicationRecord

  belongs_to :mother, :class_name => "Movement", :foreign_key => 'mother_id'
  has_many :movements, :class_name => "Movement", :foreign_key => 'mother_id'
  has_many :tribes, :class_name => "Tribe", :foreign_key => 'mother_id'

end
