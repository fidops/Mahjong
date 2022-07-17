class Api::V1::GamesController < ApplicationController
  before_action :set_game, only: %i[update destroy]

  # GET /games
  # GET /games.json
  def index
    @games = Game.all
  end

  # PATCH/PUT /games/1
  # PATCH/PUT /games/1.json
  def update
    if @game.update(game_params)
      render :show, status: :ok
    else
      render json: @game.errors, status: :unprocessable_entity
    end
  end

  # DELETE /games/1
  # DELETE /games/1.json
  def destroy
    @game.destroy
    head :no_content
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_game
    @game = Game.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def game_params
    params
      .permit(
        :east_id,
        :south_id,
        :west_id,
        :north_id,
        :east_score,
        :south_score,
        :west_score,
        :north_score,
        :match_id
      )
  end
end
