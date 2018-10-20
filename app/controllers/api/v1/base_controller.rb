module Api
  module V1
    class BaseController < ApplicationController

      def get_random_string(chars, prefix = '')
        string = (0...chars).map { ('a'..'z').to_a[rand(26)] }.join
        return "#{prefix}_#{string}"
      end

      
      def is_integer?(astring)
        true if Integer(astring) rescue false
      end

    end
  end
end
