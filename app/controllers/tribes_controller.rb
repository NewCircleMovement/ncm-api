class TribesController < ApplicationController
  before_action :set_tribe, only: [:show, :update, :destroy]

  # GET /tribes
  def index
    @tribes = Tribe.all

    render json: @tribes
  end

  # GET /tribes/1
  def show
    render json: @tribe
  end

  # POST /tribes
  def create
    @tribe = Tribe.new(tribe_params)

    if @tribe.save
      render json: @tribe, status: :created, location: @tribe
    else
      render json: @tribe.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /tribes/1
  def update
    if @tribe.update(tribe_params)
      render json: @tribe
    else
      render json: @tribe.errors, status: :unprocessable_entity
    end
  end

  # DELETE /tribes/1
  def destroy
    @tribe.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tribe
      @tribe = Tribe.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def tribe_params
      params.require(:tribe).permit(:slug, :name, :mother_id, :data)
    end
end
