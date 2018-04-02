require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  test '用户注册集成测试-失败测试' do
    # 访问注册页面
    get signup_path

    # 向user#create发送POST请求
    # assert_no_difference方法会比较给定参数执行前后值的变化
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

end
