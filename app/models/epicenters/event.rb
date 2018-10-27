# == Schema Information
#
# Table name: events
#
#  id         :bigint(8)        not null, primary key
#  slug       :string
#  name       :string
#  data       :jsonb
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Event < Epicenter

    
end 
