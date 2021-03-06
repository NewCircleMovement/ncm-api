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

class Tribe < Epicenter
  belongs_to :mother, :class_name => "Movement", :foreign_key => 'mother_id'
end
