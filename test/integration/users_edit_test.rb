require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:ff4c00)
    @bad_guy = users(:bad_guy)
  end

  def patch_user_path(user:, name: 'mike', email: 'mikeposner@163.com', password: '8ej3jd76773k5h788ej3UYR_OLK', password_confirmation: '8ej3jd76773k5h788ej3UYR_OLK')
    patch user_path(user), params: {user: { name: name, email: email, password: password, password_confirmation: password_confirmation}}
  end

  test '用户信息编辑失败测试' do
    log_in_as(@user)
    get edit_user_path(@user)
    assert_template 'users/edit'
    patch_user_path(user: @user, name: 'mike', email: '', password: '8ej3jd76773k5h', password_confirmation: '8ej3jd76773k5h788ej3UYR_OLK')
    assert_template 'users/edit'
  end

  test '用户信息编辑成功测试' do
    log_in_as(@user)
    get edit_user_path(@user)
    assert_template 'users/edit'

    patch_user_path(user: @user)

    assert_not flash.empty?
    assert_redirected_to @user

    @user.reload
    assert_equal 'mike', @user.name
    assert_equal 'mikeposner@163.com', @user.email

  end

  def not_login_edit_user_shout_redirected_login_page
    get edit_user_path(@user)
    assert_not flash.empty?
    assert_redirected_to login_path
  end

  def not_login_update_user_shout_redirected_login_page
    patch_user_path(user: @user)
    assert_not flash.empty?
    assert_redirected_to login_path
  end

  test '前置过滤器测试' do
    # 编写测试不仅仅是为了避免代码改动引起回归问题
    # 比如用户的修改和更新,如果不加前置过滤器logged_in_user,代码同样不会报错,但是会造成重大的安全漏洞
    # 或许避免这种不会报错的错误代码才是测试代码的价值所在,这种测试是万万不能或缺的.
    # before_action :logged_in_user, only: [:edit, :update]

    not_login_edit_user_shout_redirected_login_page

    not_login_update_user_shout_redirected_login_page

  end

  test '未登录状态下访问修改页面登录后跳转到原目标页面测试' do

    not_login_edit_user_shout_redirected_login_page

    log_in_as(@user)
    assert_redirected_to edit_user_path(@user)

    # 确保session里面记录的地址被及时清空,避免不必要的重定向
    check_session_remember_url_clean

  end

end
