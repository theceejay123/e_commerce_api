require 'test_helper'

class PhotographersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @photographer = photographers(:one)
  end

  test "should get index" do
    get photographers_url
    assert_response :success
  end

  test "should get new" do
    get new_photographer_url
    assert_response :success
  end

  test "should create photographer" do
    assert_difference('Photographer.count') do
      post photographers_url, params: { photographer: { description: @photographer.description, full_name: @photographer.full_name } }
    end

    assert_redirected_to photographer_url(Photographer.last)
  end

  test "should show photographer" do
    get photographer_url(@photographer)
    assert_response :success
  end

  test "should get edit" do
    get edit_photographer_url(@photographer)
    assert_response :success
  end

  test "should update photographer" do
    patch photographer_url(@photographer), params: { photographer: { description: @photographer.description, full_name: @photographer.full_name } }
    assert_redirected_to photographer_url(@photographer)
  end

  test "should destroy photographer" do
    assert_difference('Photographer.count', -1) do
      delete photographer_url(@photographer)
    end

    assert_redirected_to photographers_url
  end
end
