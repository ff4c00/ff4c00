require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest

  def set_up
    post users_path, params: {user: { name: 'mikeposner', email: 'mikeposner@163.com', password: 'oiU&hgt%009_kiou', password_confirmation: 'oiU&hgt%009_kiou'}}
  end

  def setup
    # 使用固件user.yml中生成的ff4c00用户
    @user = users(:ff4c00)
  end

  # 闪现消息在一个生命周期内是持续存在的,而重新渲染页面(render)不算是一次新请求
  # 该测试就是为了避免重新渲染登录页面后闪现消息在打开其他页面后仍然存在
  test '闪现消息生命周期检查' do
    set_up
    get login_path
    assert_template 'sessions/new'

    post login_path, params: {session: {email: 'mikeposner@163.com', password: ''}}
    # 通过flash的错误信息发现mikeposner@163.com并未注册,所以添加了set_up方法
    assert_template 'sessions/new', "#{flash.first}"
    assert_not flash.empty?

    get root_path
    assert flash.empty?
  end

  test "测试布局变化" do

    # 登录后布局变化
    get login_path
    post login_path, params: {session: {email: @user.email, password: 'password'}}
    assert is_logged_in?
    assert_redirected_to user_url(@user)
    # 访问重定向后的目标地址
    follow_redirect!
    # 确认页面为登录链接地址的a标签个数为0
    assert_select 'a[href=?]', login_path, count: 0
    assert_select 'a[href=?]', logout_path
    assert_select 'a[href=?]', user_path(@user)

    # 退出后布局变化
    delete logout_path
    assert_not is_logged_in?
    assert_redirected_to root_path
    follow_redirect!
    assert_select 'a[href=?]', login_path, count: 1
    assert_select 'a[href=?]', logout_path, count: 0
    assert_select 'a[href=?]', user_path(@user), count: 0

  end

end
