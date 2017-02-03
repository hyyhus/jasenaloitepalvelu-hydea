require 'test_helper'

class BasketsControllerTest < ActionController::TestCase
  setup do
    @basket = baskets(:basketOne)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:baskets)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create basket" do
    assert_difference('Basket.count') do
      post :create, basket: { name: @basket.name }
    end

    assert_redirected_to basket_path(assigns(:basket))
  end

  test "should show basket" do
    get :show, id: @basket
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @basket
    assert_response :success
  end

  test "should update basket" do
    patch :update, id: @basket, basket: { name: @basket.name }
    assert_redirected_to basket_path(assigns(:basket))
  end

  test "should destroy basket" do
    assert_difference('Basket.count', -1) do
      delete :destroy, id: @basket
    end

    assert_redirected_to baskets_path
  end
end
