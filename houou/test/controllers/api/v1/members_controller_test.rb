require 'test_helper'

class Api::V1::MembersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @member = create(:member)
  end

  test 'should get index' do
    get api_v1_members_url, as: :json
    assert_response :success
  end

  test 'should create member' do
    params = {
      member: {
        discord_id: '0' * 18,
        name: 'Temporary name'
      }
    }
    assert_difference('Member.count') do
      post api_v1_members_url, params:, as: :json
    end

    assert_response :created
  end

  test 'should show member' do
    get api_v1_member_url(@member), as: :json
    assert_response :success
  end

  test 'should update member' do
    params = {
      member: {
        id: @member.id,
        name: 'updated name'
      }
    }
    patch api_v1_member_url(@member), params:, as: :json
    assert_response :success
  end

  test 'should destroy member' do
    assert_difference('Member.count', -1) do
      delete api_v1_member_url(@member), as: :json
    end

    assert_response :no_content
  end
end
