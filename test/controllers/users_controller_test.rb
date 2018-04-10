require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:ff4c00)
  end

  test "登录页面" do
    get signup_path
    assert_response :success
  end

  test '列表页面权限保护' do

    # 未登录用户访问列表页面重定向到登录页面
    get users_path
    assert_redirected_to login_path

    # 登录后返回原目标列表页面
    log_in_as(@user)
    assert_redirected_to users_path
    check_session_remember_url_clean

  end



end
