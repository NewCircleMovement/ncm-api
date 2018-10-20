class Epicenter < ApplicationRecord

  self.inheritance_column = :type

  scope :users, -> { where(type: 'User') }
  scope :events, -> { where(type: 'Event') }
  scope :centers, -> { where(type: 'Center') }

  # include article type in response
  def serializable_hash options=nil
    super.merge "type" => type
  end

  def self.types
    %w(Event, User, Center)
  end
  
  def self.get(type)
    case type
    when 'Event'
      return self.events
    when 'User'
      return self.users
    when 'Center'
      return self.centers
    end

  end

  def self.of_type(type)
    case type
    when 'Event'
      return self::Event
    when 'User'
      return self::User
    when 'Center'
      return self::Center
    end
  end

  def to_param
    self.slug
  end

end
