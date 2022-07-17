class Api::V1::MatchGamesController < ApplicationController
  before_action :set_match

  def index
    @games = @match.games
  end

  def create
    @game = @match.games.new(game_params)

    if @game.save
      render :show, status: :created, location: api_v1_match_games_url(@match)
    else
      render json: @game.errors, status: :unprocessable_entity
    end
  end

  private

  def set_match
    @match = Match.find(params[:match_id])
  end

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
