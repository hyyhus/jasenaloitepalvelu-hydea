require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  setup do
    @user = users(:userOne)
    current_user = users(:userFour)
    session[:user_id] = current_user.id
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:users)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create user" do
    assert_difference('User.count') do
      post :create, user: {admin: @user.admin, email: @user.email, moderator: @user.moderator, name: @user.name, persistent_id: @user.persistent_id, title: @user.title }
    end

    assert_redirected_to user_path(assigns(:user))
  end

  test "should show user" do
    get :show, id: @user
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @user
    assert_response :success
  end

  test "should update user" do
    patch :update, id: @user, user: { admin: @user.admin, email: @user.email, moderator: @user.moderator, name: @user.name, persistent_id: @user.persistent_id, title: @user.title }
    assert_redirected_to user_path(assigns(:user))
  end

  test "should destroy user" do
    assert_difference('User.count', -1) do
      delete :destroy, id: @user
    end

    assert_redirected_to users_path
  end
end
