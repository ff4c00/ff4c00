require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest

	def setup
		ActionMailer::Base.deliveries.clear
	end 

  test '用户注册集成测试-失败测试' do
    # 访问注册页面
    get signup_path

    # 向user#create发送POST请求
    # assert_no_difference方法会比较给定参数执行前后值的变化,这里期望的是User的数量在提交前后不发生变化
    assert_no_difference 'User.count' do
      #  这里的params格式与后台user#create收到的参数格式保持一致
      post users_path, params: {user: { name: '', email: '', password: '321', password_confirmation: '123'}}
    end

    # 检查提交失败后是否会重新渲染user#new
    assert_template 'users/new'

    # 错误消息模板检查
    assert_select "div#error_explanation"
    assert_select "div.alert"
    assert_select "div.alert-danger"


    # 从技术层面讲访问注册页面和提交表单之间的请求没有任何关系,但集成测试应该是模拟的正常操作的流程,是在讲述一个完整的故事.
  end

  test '用户注册集成测试-成功测试' do
    get signup_path

    # 这里期望的结果是User的数量发生变化并且变化的数量为1
		# 如果期望数量减少,比如删除用户参数为:-1
    assert_difference 'User.count', 1 do
      post users_path, params: {user: { name: 'mikeposner', email: 'mikeposner@163.com', password: 'password', password_confirmation: 'password'}}
    end

 		assert_equal 1, ActionMailer::Base.deliveries.size
		# assigns的作用是获取相应动作中的实例变量,如:
		# User控制器的create动作定义了实例变量@user,则可以在测试中使用assigns(:user)获取到变量值
		user = assigns(:user)
		assert_not user.activated?
		log_in_as(user)
		assert_not is_logged_in?

		# 激活令牌验证测试

		# 令牌无效测试
		get edit_account_activation_path('bad_token', email: user.email)
		assert_not is_logged_in?
		# 有效令牌 无效邮箱测试
		get edit_account_activation_path(user.activation_token, email: 'bad_email')
		assert_not is_logged_in?
		# 有效性测试
		get edit_account_activation_path(user.activation_token, email: user.email)
		assert user.reload.activated?
		# 激活令牌验证测试 end
		# 跟踪重定向
    follow_redirect!

    assert_template 'users/show'
    assert_select "div.alert-success", text: "账户激活成功!"
    assert is_logged_in?

  end

end
