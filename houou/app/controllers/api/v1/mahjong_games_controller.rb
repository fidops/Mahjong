class Api::V1::MahjongGamesController < ApplicationController
  before_action :set_mahjong_game, only: %i[show update destroy]

  # GET /mahjong_games
  # GET /mahjong_games.json
  def index
    @mahjong_games = MahjongGame.all
  end

  # GET /mahjong_games/1
  # GET /mahjong_games/1.json
  def show; end

  # POST /mahjong_games
  # POST /mahjong_games.json
  def create
    @mahjong_game = MahjongGame.new(mahjong_game_params)

    if @mahjong_game.save
      render :show, status: :created, location: @mahjong_game
    else
      render json: @mahjong_game.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /mahjong_games/1
  # PATCH/PUT /mahjong_games/1.json
  def update
    if @mahjong_game.update(mahjong_game_params)
      render :show, status: :ok, location: @mahjong_game
    else
      render json: @mahjong_game.errors, status: :unprocessable_entity
    end
  end

  # DELETE /mahjong_games/1
  # DELETE /mahjong_games/1.json
  def destroy
    @mahjong_game.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_mahjong_game
    @mahjong_game = MahjongGame.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def mahjong_game_params
    params
      .require(:mahjong_game)
      .permit(:east_id, :south_id, :west_id, :north_id, :east_score, :south_score, :west_score, :north_score, :mahjong_match_id)
  end
end
