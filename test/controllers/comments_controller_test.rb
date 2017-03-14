require 'test_helper'

class CommentsControllerTest < ActionController::TestCase
  setup do
    @comment = comments(:commentFour)
    current_user = users(:userFour)
    session[:user_id] = current_user.id
    @idea = ideas(:ideaFour)

  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:comments)
  end

  test "should get new" do #requires parameter
    get :new, params: { :id => @idea.id }
    assert_response :success
  end

  test "should create comment" do
    assert_difference('Comment.count') do
      post :create, params: { comment: { idea_id: @comment.idea_id, text: @comment.text, time: @comment.time, user_id: @comment.user_id } }
    end
    assert_redirected_to :controller => 'ideas', :action => 'show', :id => @comment.idea_id
  end

  test "should show comment" do
    get :show, params: { id: @comment }
    assert_response :success
  end

  test "should get edit" do
    get :edit, params: { id: @comment }
    assert_response :success
  end

  test "should update comment" do
    patch :update, params: { id: @comment, comment: { idea_id: @comment.idea_id, text: @comment.text, time: @comment.time, user_id: @comment.user_id } }
    assert_redirected_to comment_path(assigns(:comment))
  end

  test "should destroy comment" do
    assert_difference('Comment.count', -1) do
      delete :destroy, params: { id: @comment }
    end

    assert_redirected_to comments_path
  end
end
