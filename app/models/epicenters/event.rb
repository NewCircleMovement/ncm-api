# == Schema Information
#
# Table name: epicenters
#
#  id          :bigint(8)        not null, primary key
#  type        :string
#  parent_id   :integer
#  level       :integer
#  slug        :string
#  name        :string
#  description :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Event < Epicenter

    
end 
