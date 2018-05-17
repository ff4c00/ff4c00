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
		try_to_delete_user(url: login_path)

		# 非管理员已登录用户尝试发起删除请求
		log_in_as(@bad_guy)
		# 测试时报错,提示预期重定向到根路径而实际重定向到了login
		# 所以我怀疑这里用户用户根本没有登录成功
		# 测试发现是对的,后来想到固件里面bad_guy的邮箱没有激活所以导致登录失败
		assert is_logged_in?
		try_to_delete_user(url: root_path)

	end 


	test '未登录用户查看已关注和粉丝列表将重定向到登录页面' do 
		
		get following_user_path(@user)
		assert_redirected_to login_url

		get followers_user_path(@user)
		assert_redirected_to login_url

	end 


end
