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
        fruit = Fruit.find(params[:fruit_id])
        amount = params['amount']

        giver.fruit_basket.has_enough_fruit?(fruit.id, amount)

        permitted_params = { 
          :giver_id => giver.id, :giver_type => giver.type,
          :receiver_id => receiver.id, :receiver_type => receiver.type,
          :fruit_id => fruit.id, :amount => params[:amount]
        }
        
        transaction = FruitTransaction.new(permitted_params)

        
        # if @epicenter.save
        #   render json: @epicenter, status: :created
        # else
        #   render json: @epicenter.errors, status: :unprocessable_entity
        # end
        render json: true

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
