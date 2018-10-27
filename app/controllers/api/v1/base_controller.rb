module Api
  module V1
    class BaseController < ApplicationController

      def get_random_string(chars, prefix = '')
        string = (0...chars).map { ('a'..'z').to_a[rand(26)] }.join
        return "#{prefix}_#{string}"
      end

      def get_model(type, id)
        case type
        when 'user'
          return User.find(id)
        when 'even'
          return Event.find(id)
        end
      end
      
    end
  end
end
