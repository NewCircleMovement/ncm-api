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
  
  has_many :memberships, as: :owner
  has_many :user_memberships, through: :membershipcards, source: :owner, source_type: 'User'
  
end 
