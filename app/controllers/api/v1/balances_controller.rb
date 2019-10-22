module Api
  module V1
    class BalancesController < BaseController
      before_action :set_balance_holder, only: [:show, :show_all, :update, :destroy]

      # GET /balances
      def index
        @balances = Balance.all

        render json: @balances
      end

      # GET /balances/1
      def show
        @epicenter = get_epicenter(@holder_type, @holder_id)
        @balance = @epicenter.get_balance(@fruit.id)
        render json: @balance
      end

      def show_all
        @epicenter = get_epicenter(@holder_type, @holder_id)
        render json: @epicenter.balances
      end

      # DELETE /balances/1
      def destroy
        @balance.destroy
      end

      private
        # Use callbacks to share common setup or constraints between actions.

        def set_balance_holder
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