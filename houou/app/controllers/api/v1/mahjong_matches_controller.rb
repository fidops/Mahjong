class Api::V1::MahjongMatchesController < ApplicationController
  before_action :set_mahjong_match, only: %i[show update destroy]

  # GET /mahjong_matches
  # GET /mahjong_matches.json
  def index
    @mahjong_matches = MahjongMatch.all
  end

  # GET /mahjong_matches/1
  # GET /mahjong_matches/1.json
  def show; end

  # POST /mahjong_matches
  # POST /mahjong_matches.json
  def create
    @mahjong_match = MahjongMatch.new(mahjong_match_params)

    if @mahjong_match.save
      render :show, status: :created, location: @mahjong_match
    else
      render json: @mahjong_match.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /mahjong_matches/1
  # PATCH/PUT /mahjong_matches/1.json
  def update
    if @mahjong_match.update(mahjong_match_params)
      render :show, status: :ok, location: @mahjong_match
    else
      render json: @mahjong_match.errors, status: :unprocessable_entity
    end
  end

  # DELETE /mahjong_matches/1
  # DELETE /mahjong_matches/1.json
  def destroy
    @mahjong_match.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_mahjong_match
    @mahjong_match = MahjongMatch.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def mahjong_match_params
    params.require(:mahjong_match).permit(:name)
  end
end
