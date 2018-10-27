module Api
  module V1
    class TransactionsController < BaseController
      before_action :set_entities
      # before_action :set_epicenter, only: [:show, :update, :destroy]

      # def index
      #   if params[:level].present?
      #     @epicenters = Epicenter.get(@type).where(:level => params[:level])
      #   else
      #     @epicenters = Epicenter.get(@type)
      #   end
        
      #   render json: @epicenters
      # end


      # def show
      #   render json: @epicenter
      # end


      def create
        fruit = Fruit.find(params[:fruit_id])

        if fruit
          amount = params['amount'].to_i
          if @giver.has_enough_fruit?(fruit.id, amount)
            @giver.give_fruit_to(@receiver, fruit.id, amount)
            render json: { :success => true, :response => 'Successful transaction' }, status: 200
          else
            render json: { :success => false, :response => 'Not enough fruit' }, status: 202
          end
        else
          render json: { :success => false, :response => 'No such fruit'}, status: 202
        end
      end


      # def update
      #   if @epicenter.update(epicenter_params)
      #     render json: @epicenter
      #   else
      #     render json: @epicenter.errors, status: :unprocessable_entity
      #   end
      # end

      # def destroy
      #   @epicenter.destroy
      # end


      private
        def set_entities
          @giver = get_model(params[:giver_type], params[:giver_id])
          @receiver = get_model(params[:receiver_type], params[:receiver_id])

          unless @giver and @receiver
            raise "No such user"
          end
        end

        # def get_model(type, id)
        #   case type
        #   when 'user'
        #     return User.find(id)
        #   when 'even'
        #     return Event.find(id)
        #   end
        # end

        def permitted_params
          params.permit(:giver_id, :giver_type, :receiver_id, :receiver_type, :amount)
        end
    end
  end
end
