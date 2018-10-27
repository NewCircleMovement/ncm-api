module Api
  module V1
    class BalancesController < BaseController
      before_action :set_balance_owner, only: [:show, :update, :destroy]

      # GET /balances
      def index
        @balances = balance.all

        render json: @balances
      end

      # GET /balances/1
      def show
        @holder = get_epicenter(@holder_type, @holder_id)
        render json: @balance
      end

      def show_all

      end

      # POST /balances
      def create
        @balance = Balance.new(balance_params)

        if @balance.save
          render json: @balance, status: :created, location: @balance
        else
          render json: @balance.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /balances/1
      def update
        if @balance.update(balance_params)
          render json: @balance
        else
          render json: @balance.errors, status: :unprocessable_entity
        end
      end

      # DELETE /balances/1
      def destroy
        @balance.destroy
      end

      private
        # Use callbacks to share common setup or constraints between actions.
        def set_balance
          @holder_type = params['holder_type']
          @holder_id = params['holder_id']
          @fruit_id = params['fruit_id']
        end

        # Only allow a trusted parameter "white list" through.
        def balance_params
          params.require(:balance).permit(:slug, :name, :record)
        end
    end
  end
end