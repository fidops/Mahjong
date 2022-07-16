require 'test_helper'

class Api::V1::MahjongJansousControllerTest < ActionDispatch::IntegrationTest
  setup do
    @mahjong_jansou = create(:mahjong_jansou)
  end

  test 'should get index' do
    get api_v1_mahjong_jansous_url, as: :json
    assert_response :success
  end

  test 'should create mahjong_jansou' do
    params = {
      mahjong_jansou: {
        name: Faker::Name.name,
        address: Faker::Address.full_address,
        google_map_url: Faker::Internet.url,
        note: '602'
      }
    }
    assert_difference('MahjongJansou.count') do
      post api_v1_mahjong_jansous_url, params:, as: :json
    end

    assert_response :created
  end

  test 'should show mahjong_jansou' do
    get api_v1_mahjong_jansou_url(@mahjong_jansou), as: :json
    assert_response :success
  end

  test 'should update mahjong_jansou' do
    params = {
      mahjong_jansou: {
        name: Faker::Name.name,
        address: Faker::Address.full_address,
        google_map_url: Faker::Internet.url,
        note: '602'
      }
    }
    patch api_v1_mahjong_jansou_url(@mahjong_jansou), params:, as: :json
    assert_response :success
  end

  test 'should destroy mahjong_jansou' do
    assert_difference('MahjongJansou.count', -1) do
      delete api_v1_mahjong_jansou_url(@mahjong_jansou), as: :json
    end

    assert_response :no_content
  end
end
