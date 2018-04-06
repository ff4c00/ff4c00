require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest

  def set_up
    post users_path, params: {user: { name: 'mikeposner', email: 'mikeposner@163.com', password: 'oiU&hgt%009_kiou', password_confirmation: 'oiU&hgt%009_kiou'}}
  end

  def setup
    # 使用固件user.yml中生成的ff4c00用户
    @user = users(:ff4c00)
  end

  def logout_change
    delete logout_path
    assert_not is_logged_in?
    assert_redirected_to root_path
    follow_redirect!
    assert_select 'a[href=?]', login_path, count: 1
    assert_select 'a[href=?]', logout_path, count: 0
    assert_select 'a[href=?]', user_path(@user), count: 0
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
    logout_change

    # 捕获问题: 用户打开多个窗口访问网站,在一个窗口退出登录后在其他窗口再次退出登录会产生错误
    # NoMethodError: undefined method `forget' for nil:NilClass...
    # 模拟用户在另一个窗口点击退出链接
    logout_change

    # 捕获问题: 用户在多个浏览器中登录,如:L1和L2,L1中退出了,L2未退出,关闭L2再重新打开会出现问题,因为
    # L1退出时已经把记忆摘要remember_digest清空(nil)了,L2重新打开时,session虽然清空了但cokkies中的user_id和remember_token还在,运行session_helper#current的if user && user.authenticated?(cookies[:remember_token])时,后面的条件会报错.这个问题将在user_test的"用户多浏览器登录退出问题"测试中捕获.

  end

  test "测试记住我功能"  do

    # 记住我
    log_in_as(@user)
    # 集成测试中无法获取虚拟属性,但可以通过assigns方法访问控制器中定义的实例变量
    assert_equal cookies['remember_token'], assigns(:user).remember_token

    logout_change

    #  不,还是忘掉我吧,忘掉那些曾经的欢笑,忘掉那些曾经的秘密,就让那些曾经随风飘走,随清泉流去,随健硕的雄鹰展翅在那辽阔的苍穹,随神秘的蓝鲸浪逐那深邃的海洋,就让我埋没在那世俗的人群中,没有那南山下的野菊,没有那北海上展翅翱翔的鲲鹏.但 你看啊,在那广阔无垠的沙漠中曾留下我的足迹,那一串串印记在讲述着,讲述着曾经的欢笑,低语着那些曾经的秘密.历史终将刻录下这点点滴滴,因为我曾来过,曾写下过,曾用那歪歪扭扭稚嫩的字体写下:蒋金栋到此一游~~~
    log_in_as(@user, remember_me: '0')
    assert_not cookies['remember_token'].present?

  end

end
