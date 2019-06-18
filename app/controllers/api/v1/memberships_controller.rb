module Api
  module V1
    class MembershipsController < BaseController
      before_action :set_epicenter
      before_action :set_membership, only: [:show, :update, :destroy, :enrol]
      before_action :set_applicant, only: [:enrol]


      def index
        @memberships = @epicenter.memberships

        render json: @memberships
      end


      def show
        render json: @membership
      end


      def create
        @membership = @epicenter.new(membership_params)
        if @membership.save
          render json: @membership, status: :created, location: @membership
        else
          render json: @membership.errors, status: :unprocessable_entity
        end
      end

      
      def enrol
        if @applicant.is_member_of?(@membership)
          render json: { :success => false, :response => 'Already a member' }, status: 422
        elsif @applicant.can_apply_for?(@membership)
          if @epicenter.give_membership_to(@applicant, @membership)
            render json: { :success => true, :response => 'Successful created membership' }, status: 200
          else
            render json: { :success => false, :response => 'Membership could not be created' }, status: 422
          end
        else
          render json: { :success => false, :response => "Applicant can not apply (not enough fruit)"}, status: 204
        end
      end


      def update
        if @membership.update(membership_params)
          render json: @membership
        else
          render json: @membership.errors, status: :unprocessable_entity
        end
      end


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

        def set_membership
          @membership = @epicenter.memberships.find(params[:membership_id])
          if not @membership
            raise ActionController::RoutingError.new('Membership not found')
          end
        end

        def set_applicant
          @applicant = get_epicenter(params[:applicant_type], params[:applicant_id])
          if not @applicant
            raise ActionController::RoutingError.new('Applicant not found')
          end
        end

        # Only allow a trusted parameter "white list" through.
        def membership_params
          params.require(:membership).permit(:owner_id, :owner_type, :name, :description, :fee, :gain, :rhythm)
        end
    end
  end
end
