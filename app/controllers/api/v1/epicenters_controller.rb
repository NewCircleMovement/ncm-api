module Api
  module V1
    class EpicentersController < BaseController
      before_action :set_epicenter
      before_action :set_fruit, only: [:balance, :transactions, :give_fruit]


      def balance
        @balance = @epicenter.get_balance(@fruit.id)

        render json: @balance
      end

      def transactions
        start_date = Date.parse params[:start] rescue nil
        end_date = Date.parse params[:end] rescue nil

        @transactions = Transaction.where(fruit_id: @fruit.id).between(start_date, end_date).where('giver_type=? and giver_id=? OR receiver_type=? and receiver_id=?', "User", 1, "User", 1)

        render json: @transactions
      end


      def transactions_given
        start_date = Date.parse params[:start] rescue nil
        end_date = Date.parse params[:end] rescue nil

        @transactions = @epicenter.transactions_given.where(:fruit_id => @fruit.id).between(start_date, end_date)

        render json: @transactions
      end

      def transactions_received
        start_date = Date.parse params[:start] rescue nil
        end_date = Date.parse params[:end] rescue nil

        @transactions = @epicenter.transactions_received.where(:fruit_id => @fruit.id).between(start_date, end_date)

        render json: @transactions
      end

      
      def give_fruit
        amount = params[:amount].to_i
        unless amount and amount > 0
          render json: { :success => false, :message => "Amount must be an integer larger than 0" }, status: 202
          return 
        end
        
        fruit = Fruit.find(params[:fruit_id])
        unless fruit
          render json: { :success => false, :message => "No such fruit" }, status: 404
          return
        end

        receiver = Epicenter.find_epicenter(params[:receiver_type], params[:receiver_id])
        unless receiver
          render json: { :success => false, :message => 'Receiving epicenter not found' }, status: 404
          return
        end

        if @epicenter.has_enough_fruit?(fruit.id, amount)
          transaction = @epicenter.give_fruit_to(receiver, fruit.id, amount)
          if transaction
            render json: { :success => true, :message => 'Successfully created transaction', transaction: transaction }, status: 200
          else
            render json: { :success => false, :message => 'Transaction was not created' }, status: 500
          end
        else
          render json: { :success => false, :message => "#{@epicenter.type} #{@epicenter.id} does not have enough fruit" }, status: 202
        end
      end

      private 

        def set_fruit
          @fruit = Fruit.find_by(id: params[:fruit_id])
        end

    end
  end
end
