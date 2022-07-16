require 'test_helper'

class Api::V1::AdministratorsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @administrator = create(:administrator)
  end

  test 'should get index' do
    get api_v1_administrators_url, as: :json
    assert_response :success
  end

  test 'should create administrator' do
    assert_difference('Administrator.count') do
      post api_v1_administrators_url,
           params: { administrator: { password_digest: @administrator.password_digest, userid: @administrator.userid } }, as: :json
    end

    assert_response :created
  end

  test 'should show administrator' do
    get api_v1_administrator_url(@administrator), as: :json
    assert_response :success
  end

  test 'should update administrator' do
    patch api_v1_administrator_url(@administrator),
          params: { administrator: { password_digest: @administrator.password_digest, userid: @administrator.userid } }, as: :json
    assert_response :success
  end

  test 'should destroy administrator' do
    assert_difference('Administrator.count', -1) do
      delete api_v1_administrator_url(@administrator), as: :json
    end

    assert_response :no_content
  end
end
