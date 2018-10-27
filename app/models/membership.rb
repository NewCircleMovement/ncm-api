# == Schema Information
#
# Table name: memberships
#
#  id          :bigint(8)        not null, primary key
#  owner_id    :integer
#  owner_type  :string
#  name        :string
#  description :text
#  fee         :integer
#  gain        :integer
#  rhythm      :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Membership < ApplicationRecord
  belongs_to :owner, :polymorphic => true

  def members_count
    Membershipcard.where(:membership_id => self.id).count
  end

end
