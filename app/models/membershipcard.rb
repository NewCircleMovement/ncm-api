# == Schema Information
#
# Table name: membershipcards
#
#  id             :bigint(8)        not null, primary key
#  membership_id  :integer
#  owner_id       :integer
#  owner_type     :string
#  epicenter_id   :integer
#  epicenter_type :string
#  active         :boolean          default(TRUE)
#  payment_id     :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class Membershipcard < ApplicationRecord

  belongs_to :owner, :polymorphic => true
  belongs_to :epicenter, :polymorphic => true
  belongs_to :membership

end
