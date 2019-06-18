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

class User < Epicenter
    
  has_many :caretaker_events, foreign_key: :caretaker_id, class_name: 'Event'

end 
