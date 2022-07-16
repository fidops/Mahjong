require 'test_helper'

class Api::V1::MahjongMatchesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @mahjong_match = create(:mahjong_match)
  end

  test 'should get index' do
    get api_v1_mahjong_matches_url, as: :json
    assert_response :success
  end

  test 'should create mahjong_match' do
    assert_difference('MahjongMatch.count') do
      post api_v1_mahjong_matches_url, params: { mahjong_match: { name: @mahjong_match.name } }, as: :json
    end

    assert_response :created
  end

  test 'should show mahjong_match' do
    get api_v1_mahjong_match_url(@mahjong_match), as: :json
    assert_response :success
  end

  test 'should update mahjong_match' do
    patch api_v1_mahjong_match_url(@mahjong_match),
          params: { mahjong_match: { name: @mahjong_match.name } }, as: :json
    assert_response :success
  end

  test 'should destroy mahjong_match' do
    assert_difference('MahjongMatch.count', -1) do
      delete api_v1_mahjong_match_url(@mahjong_match), as: :json
    end

    assert_response :no_content
  end
end
