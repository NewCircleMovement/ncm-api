module Api
  module V1
    class BaseController < ApplicationController

      def get_random_string(chars, prefix = '')
        string = (0...chars).map { ('a'..'z').to_a[rand(26)] }.join
        return "#{prefix}_#{string}"
      end

      def get_epicenter(type, id)
        case type.downcase
        when 'movement'
          return Movement.find(id)
        when 'tribe'
          return Tribe.find(id)
        when 'event'
          return Event.find(id)
        when 'user'
          return User.find(id)
        end
        
      end
      
    end
  end
end
