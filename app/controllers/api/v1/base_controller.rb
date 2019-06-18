module Api
  module V1
    class BaseController < ApplicationController

      def set_epicenter
        @epicenter = Epicenter.find_epicenter(params[:epicenter_type], params[:epicenter_id])
        if not @epicenter
          raise ActionController::RoutingError.new('Epicenter not found')
        end
      end

      def is_integer?(string)
        return true if Integer(string) rescue false
      end

      def get_random_string(chars, prefix = '')
        string = (0...chars).map { ('a'..'z').to_a[rand(26)] }.join
        return "#{prefix}_#{string}"
      end
      
    end
  end
end
