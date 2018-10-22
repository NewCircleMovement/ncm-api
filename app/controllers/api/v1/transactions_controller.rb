module Api
  module V1
    class TransactionsController < BaseController
      # before_action :set_type
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
        giver = Epicenter.find(params[:giver_id])
        receiver = Epicenter.find(params[:receiver_id])
        fruit_id = params[:fruit_id]
        amount = params['amount']

        if giver.has_enough_fruit?(fruit_id, amount)
          giver.give_fruit_to(receiver, fruit_id, amount)
          render json: { :success => true, :response => 'Successful transaction' }, status: 200
        else
          render json: { :success => false, :response => 'Not enough fruit' }, status: 202
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


      # private
      #   def set_type
      #     @type = params[:type]
      #   end

      #   def set_epicenter
      #     epicenters = Epicenter.get(@type)
      #     if params['id'].is_integer?
      #       @epicenter = epicenters.find_by(id: params[:id])
      #     else
      #       @epicenter = epicenters.find_by(slug: params[:id])
      #     end
      #   end

        def permitted_params
          params.permit(:giver_id, :giver_type, :receiver_id, :receiver_type, :amount)
        end
    end
  end
end
