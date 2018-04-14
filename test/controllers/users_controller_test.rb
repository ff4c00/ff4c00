require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:ff4c00)
    @bad_guy = users(:bad_guy)
  end

	def try_to_delete_user(url:)
		assert_no_difference 'User.count' do 
			delete user_path(@bad_guy)
			assert_redirected_to url 
		end
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

	test '禁止通过PATCH更新请求修改admin属性检查' do 
		log_in_as(@bad_guy)
		assert_not @bad_guy.admin?
		patch user_path(@bad_guy), params: {user: {admin: true}}
		assert_not @bad_guy.reload.admin?
	end 

	test '无权限用户尝试发送删除用户请求' do
		
		# 未登录用户尝试发起删除请求
		try_to_delete_user(url: login_url)

		# 非管理员已登录用户尝试发起删除请求
		log_in_as(@bad_guy)
		try_to_delete_user(url: root_path)

	end 


end
