module Api
  module V1
    class FruitsController < BaseController
      before_action :set_fruit, only: [:show, :update, :destroy]

      def index
        @fruits = Fruit.all
        
        render json: @fruits
      end


      def show
        render json: @fruit
      end


      def create
        @fruit = Fruit.new(fruit_params)
        if @fruit.save
          render json: @fruit, status: :created
        else
          render json: @fruit.errors, status: :unprocessable_entity
        end
      end


      def update
        if @fruit.update(fruit_params)
          render json: @fruit
        else
          render json: @fruit.errors, status: :unprocessable_entity
        end
      end

      def destroy
        @fruit.destroy
      end


      private
        def set_fruit
          @fruit = Fruit.find_by(id: params[:id])
        end

        def fruit_params
          params.require(:fruit).permit(:name, :owner_id, :owner_type, :monthly_decay)
        end
    end
  end
end
