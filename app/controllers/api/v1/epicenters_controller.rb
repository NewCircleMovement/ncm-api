module Api
  module V1
    class EpicentersController < BaseController
      before_action :set_type
      before_action :set_epicenter, only: [:show, :update, :destroy]

      def index
        if params[:level].present?
          @epicenters = @model.where(:level => params[:level])
        else
          @epicenters = @model.all
        end
        
        render json: @epicenters
      end


      def show
        render json: @epicenter
      end


      def create
        @epicenter = @model.new(epicenter_params)
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
          if @type
            @model = Epicenter.get(@type)
          else
            @model = Epicenter
          end
        end

        def set_epicenter

          if params['id'].is_integer?
            @epicenter = @model.find_by(id: params[:id])
          else
            @epicenter = @model.find_by(slug: params[:id])
          end
        end

        def epicenter_params
          params.require(:epicenter).permit(:id, :type, :slug, :level, :name, :description)
        end
    end
  end
end
