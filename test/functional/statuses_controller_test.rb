require 'test_helper'

class StatusesControllerTest < ActionController::TestCase
  setup do
    @status = statuses(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:statuses)
  end

  test "should be redirected when not logged in" do
    get :new
    assert_response :redirect
    assert_redirected_to new_user_session_path
  end

  test "should render the new page when logged in" do
    sign_in users(:rickson)
    get :new
    assert_response :success
  end

  test "should be logged in to post status" do
    post :create, status: {content:"Hello"}
    assert_response :redirect
    assert_redirected_to new_user_session_path
  end

  test "should create status when logged in" do
    sign_in users(:rickson)

    assert_difference('Status.count') do
      post :create, status: { content: @status.content }
    end

    assert_redirected_to status_path(assigns(:status))
  end

  test "should be logged in to show status" do
    get :show, id: @status
    assert_response :redirect
    assert_redirected_to new_user_session_path
  end

  test "should show status after you logged in" do
    sign_in users(:rickson)
    get :show, id: @status
    assert_response :success
  end

  test "should get edit after you sign in" do
    get :edit, id: @status
    assert_response :redirect
    assert_redirected_to new_user_session_path
  end

  test "should get edit when you logged in" do
    sign_in users(:rickson)

    get :edit, id: @status
    assert_response :success
  end

  test "should update status after logged in" do
    put :update, id: @status, status: { content: @status.content }
    assert_redirected_to new_user_session_path
  end

  test "should update status" do
    sign_in users(:rickson)
    put :update, id: @status, status: { content: @status.content }
    assert_redirected_to status_path(assigns(:status))
  end

  test "should no destroy status when no logged in" do
    delete :destroy, id: @status

    assert_redirected_to new_user_session_path
  end

  test "should destroy status" do
    sign_in users(:rickson)

    assert_difference('Status.count', -1) do
      delete :destroy, id: @status
    end

    assert_redirected_to statuses_path
  end
end
