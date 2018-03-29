require 'test_helper'

class UserTest < ActiveSupport::TestCase

  # setup 方法会在每个测试方法运行前执行
  def setup
    @user = User.new(name: 'ff4c00', email: 'ff4c00@gmail.com')
  end

  test "user是否有效检查" do
    assert @user.valid?
  end

  test "name字段检查" do
    # 检查name是否为空
    @user.name = "   "
    # assert(期望返回true)和assert_not(期望返回false)的关系相当于if和unless,present?和blank?的对立关系
    assert_not @user.valid?

    # name长度检查
    @user.name = "f"*51
    assert_not @user.valid?
  end

  test "email字段检查" do
    @user.email = "  "
    assert_not @user.valid?

    @user.email = "f"*255 + "@gmail.com"
    assert_not @user.valid?

    # 邮箱格式检查
    bad_emall_addresses = %w(ff4c00@gmail.com.163 ff4c00@gmail.c6m ff4c00@gmail,com ff4c00@gmail..com ff4c00@gmail_.com ff4c00|gmail.com ff4%00@gmail.com)
    bad_emall_addresses.each do |bad_emall_address|
      @user.email = bad_emall_address
      # 第二个可选参数用于定制错误返回信息
      assert_not @user.valid?, "#{bad_emall_address}格式应为错误格式"
    end

    # 邮箱唯一性检查
    # 上面对email进行了无效赋值,需要对@user重新初始化
    setup
    repetitor_user = @user.dup
    @user.save
    assert_not repetitor_user.valid?
    repetitor_user.email = @user.email.upcase
    assert_not repetitor_user.valid?

  end

end
