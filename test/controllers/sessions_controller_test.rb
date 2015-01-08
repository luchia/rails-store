require 'test_helper'

class SessionsControllerTest < ActionController::TestCase
  test "should get new" do
    get :new
    assert_response :success
  end

  test "should login" do
    test = users(:one)
    post :create, username: test.username, password: 'secret'
    assert_redirected_to portal_url
    assert_equal test.id, session[:user_id]
  end

  test "should fail login" do
    test = users(:one)
    post :create, username: test.username, password: 'incorrect'
    assert_redirected_to login_url
  end

  test "should logout" do
    get :destroy
    assert_redirected_to store_url
  end
end