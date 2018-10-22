module Api
  module V1
    class EpicentersController < BaseController
      before_action :set_type
      before_action :set_epicenter, only: [:show, :update, :destroy]

      def index
        if params[:level].present?
          @epicenters = Epicenter.get(@type).where(:level => params[:level])
        else
          @epicenters = Epicenter.get(@type)
        end
        
        render json: @epicenters
      end


      def show
        render json: @epicenter
      end


      def create
        @epicenter = Epicenter.of_type(@type).new(epicenter_params)
        if @epicenter.save
          render json: @epicenter, status: :created
        else
          render json: @epicenter.errors, status: :unprocessable_entity
        end
      end


      def update
        if @epicenter.update(epicenter_params)
          render json: @epicenter
        else
          render json: @epicenter.errors, status: :unprocessable_entity
        end
      end

      def destroy
        @epicenter.destroy
      end


      private
        def set_type
          @type = params[:type]
        end

        def set_epicenter
          epicenters = Epicenter.get(@type)
          if params['id'].is_integer?
            @epicenter = epicenters.find_by(id: params[:id])
          else
            @epicenter = epicenters.find_by(slug: params[:id])
          end
        end

        def epicenter_params
          params.require(:epicenter).permit(
            :id, :type, :slug, :level, :name, :description
          )
        end
    end
  end
end
