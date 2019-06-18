module BetweenDates
  extend ActiveSupport::Concern

  included do
    scope :between, -> (start_date = nil, end_date = nil, field = 'created_at') {
      if start_date and end_date
        where("#{self.table_name}.#{field} BETWEEN :start AND :end", start: start_date.beginning_of_day, end: end_date.end_of_day)
      elsif start_date
        where("#{self.table_name}.#{field} >= ?", start_date.beginning_of_day)
      elsif end_date
        where("#{self.table_name}.#{field} <= ?", end_date.end_of_day)
      else
        all
      end
    }
  end

end
