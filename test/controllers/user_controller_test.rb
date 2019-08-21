require 'test_helper'

class UserControllerTest < ActionDispatch::IntegrationTest
  test "should get name" do
    get user_name_url
    assert_response :success
  end

  test "should get username" do
    get user_username_url
    assert_response :success
  end

  test "should get password_digest" do
    get user_password_digest_url
    assert_response :success
  end

end
