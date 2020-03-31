require 'test_helper'

class OrderDetailsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @order_detail = order_details(:one)
  end

  test "should get index" do
    get order_details_url
    assert_response :success
  end

  test "should get new" do
    get new_order_detail_url
    assert_response :success
  end

  test "should create order_detail" do
    assert_difference('OrderDetail.count') do
      post order_details_url, params: { order_detail: { customer_id: @order_detail.customer_id, historical_tax: @order_detail.historical_tax, reference_number: @order_detail.reference_number, total: @order_detail.total } }
    end

    assert_redirected_to order_detail_url(OrderDetail.last)
  end

  test "should show order_detail" do
    get order_detail_url(@order_detail)
    assert_response :success
  end

  test "should get edit" do
    get edit_order_detail_url(@order_detail)
    assert_response :success
  end

  test "should update order_detail" do
    patch order_detail_url(@order_detail), params: { order_detail: { customer_id: @order_detail.customer_id, historical_tax: @order_detail.historical_tax, reference_number: @order_detail.reference_number, total: @order_detail.total } }
    assert_redirected_to order_detail_url(@order_detail)
  end

  test "should destroy order_detail" do
    assert_difference('OrderDetail.count', -1) do
      delete order_detail_url(@order_detail)
    end

    assert_redirected_to order_details_url
  end
end
