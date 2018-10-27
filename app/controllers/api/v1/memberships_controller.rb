module Api
  module V1
    class MembershipsController < BaseController
      before_action :set_epicenter, only: ['create', 'apply']
      before_action :set_applicant, only: ['apply']

      # GET /memberships
      def index
        @memberships = Membership.all

        render json: @memberships
      end

      # GET /memberships/1
      def show
        render json: @membership
      end

      # POST /memberships
      def create
        @membership = @epicenter.new(membership_params)
        if @membership.save
          render json: @membership, status: :created, location: @membership
        else
          render json: @membership.errors, status: :unprocessable_entity
        end
      end

      def apply
        if @applicant.can_apply?(@epicenter, @membership)
          if @epicenter.give_membership_to(@applicant, @membership)
            render json: { :success => true, :response => 'Successful created membership' }, status: 200
          else
            render json: { :success => false, :response => 'Membership could not be created' }, status: 204
          end
        else
          render json: { :success => false, :response => "Applicant can not apply"}
        end
      end


      # PATCH/PUT /memberships/1
      def update
        if @membership.update(membership_params)
          render json: @membership
        else
          render json: @membership.errors, status: :unprocessable_entity
        end
      end

      # DELETE /memberships/1
      def destroy
        @membership.destroy
      end

      private
        # Use callbacks to share common setup or constraints between actions.
        def set_epicenter
          @epicenter = get_epicenter(params[:epicenter_type], params[:epicenter_id])
          if not @epicenter
            raise ActionController::RoutingError.new('Epicenter not found')
          end
        end

        def set_applicant
          @applicant = get_epicenter(params[:applicant_type], params[:applicant_id])
          @membership = @epicenter.memberships.find(params[:membership_id])
          if not @applicant
            raise ActionController::RoutingError.new('Applicant not found')
          end
          if not @membership
            raise ActionController::RoutingError.new('Membership not found')
          end

        end

        # Only allow a trusted parameter "white list" through.
        def membership_params
          params.require(:membership).permit(:owner_id, :owner_type, :name, :description, :fee, :gain, :rhythm)
        end
    end
  end
end
