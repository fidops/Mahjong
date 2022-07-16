require 'test_helper'

class Api::V1::MahjongGamesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @mahjong_game = create(:mahjong_game)
  end

  test 'should get index' do
    get api_v1_mahjong_games_url, as: :json
    assert_response :success
  end

  test 'should create mahjong_game' do
    params = {
      mahjong_game: {
        east_id: @mahjong_game.east.id,
        south_id: @mahjong_game.south.id,
        west_id: @mahjong_game.west.id,
        north_id: @mahjong_game.north.id,
        east_score: Faker::Number.between(from: -10_000, to: 40_000),
        south_score: Faker::Number.between(from: -10_000, to: 40_000),
        west_score: Faker::Number.between(from: -10_000, to: 40_000),
        north_score: Faker::Number.between(from: -10_000, to: 40_000),
        mahjong_match_id: @mahjong_game.mahjong_match.id
      }
    }

    assert_difference('MahjongGame.count') do
      post api_v1_mahjong_games_url, params:, as: :json
    end

    assert_response :created
  end

  test 'should show mahjong_game' do
    get api_v1_mahjong_game_url(@mahjong_game), as: :json
    assert_response :success
  end

  test 'should update mahjong_game' do
    params = {
      mahjong_game: {
        east_id: @mahjong_game.east.id,
        south_id: @mahjong_game.south.id,
        west_id: @mahjong_game.west.id,
        north_id: @mahjong_game.north.id,
        east_score: Faker::Number.between(from: -10_000, to: 40_000),
        south_score: Faker::Number.between(from: -10_000, to: 40_000),
        west_score: Faker::Number.between(from: -10_000, to: 40_000),
        north_score: Faker::Number.between(from: -10_000, to: 40_000),
        mahjong_match_id: @mahjong_game.mahjong_match.id
      }
    }

    patch api_v1_mahjong_game_url(@mahjong_game), params:, as: :json
    assert_response :success
  end

  test 'should destroy mahjong_game' do
    assert_difference('MahjongGame.count', -1) do
      delete api_v1_mahjong_game_url(@mahjong_game), as: :json
    end

    assert_response :no_content
  end
end
