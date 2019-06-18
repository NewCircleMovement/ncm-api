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
  include BetweenDates
  
  # scope :between, -> (start_date = nil, end_date = nil, field = 'created_at') {
  #   if start_date and end_date
  #     where("#{self.table_name}.#{field} BETWEEN :start AND :end", start: start_date.beginning_of_day, end: end_date.end_of_day)
  #   elsif start_date
  #     where("#{self.table_name}.#{field} >= ?", start_date.beginning_of_day)
  #   elsif end_date
  #     where("#{self.table_name}.#{field} <= ?", end_date.end_of_day)
  #   else
  #     all
  #   end
  # }


  # belongs_to :mother, :class_name => "Tribe", :foreign_key => 'mother_id'
  belongs_to :owner, polymorphic: true
  belongs_to :caretaker, foreign_key: :caretaker_id, class_name: 'User', optional: true

  validates :slug, :presence => true, :uniqueness => true
  validates :name, :presence => true
  validates :caretaker_id, :presence => true

end 
