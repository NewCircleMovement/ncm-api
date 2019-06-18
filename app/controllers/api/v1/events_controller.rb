module Api
  module V1
    class EventsController < BaseController

      before_action :set_epicenter
      before_action :set_event, only: [:show, :update, :destroy]

      # GET /events
      def index
        start_date = Date.parse params[:start] rescue nil
        end_date = Date.parse params[:end] rescue nil
        @events = @epicenter.events.between(start_date, end_date, field='date')
      
        render json: @events
      end

      # GET /events/1
      def show
        render json: @event
      end

      # POST /events
      def create
        @event = @epicenter.events.build(event_params)

        if @event.save
          render json: @event, status: :created, location: @event
        else
          render json: @event.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /events/1
      def update
        if @event.update(event_params)
          render json: @event
        else
          render json: @event.errors, status: :unprocessable_entity
        end
      end

      # DELETE /events/1
      def destroy
        @event.destroy
      end

      private
        # Use callbacks to share common setup or constraints between actions.
        def set_event
          if is_integer?(params[:id])
            @event = @epicenter.events.find(params[:id])
          else
            @event = @epicenter.events.find_by(slug: params[:id])
          end          
        end

        # Only allow a trusted parameter "white list" through.
        def event_params
          params.require(:event).permit(:slug, :name, :caretaker_id, :data)
        end
    end
  end
end