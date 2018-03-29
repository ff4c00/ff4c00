require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  test "登录页面" do
    get signup_path
    assert_response :success
  end

end
