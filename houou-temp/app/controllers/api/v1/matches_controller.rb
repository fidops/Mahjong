class Api::V1::MatchesController < ApplicationController
  before_action :set_match, only: %i[show update destroy]

  # GET /matches
  # GET /matches.json
  def index
    @matches = Match.all
  end

  # GET /matches/1
  # GET /matches/1.json
  def show; end

  # POST /matches
  # POST /matches.json
  def create
    @match = Match.new(match_params)

    if @match.save
      render :show, status: :created, location: api_v1_match_url(@match)
    else
      render json: @match.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /matches/1
  # PATCH/PUT /matches/1.json
  def update
    if @match.update(match_params)
      render :show, status: :ok, location: api_v1_match_url(@match)
    else
      render json: @match.errors, status: :unprocessable_entity
    end
  end

  # DELETE /matches/1
  # DELETE /matches/1.json
  def destroy
    @match.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_match
    @match = Match.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def match_params
    params.permit(:name, :jansou_id)
  end
end
