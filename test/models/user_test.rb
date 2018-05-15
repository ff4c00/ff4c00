require 'test_helper'

class UserTest < ActiveSupport::TestCase

  # setup 方法会在每个测试方法运行前执行
  def setup
    @user = User.new(name: 'ff4c0', email: 'ff4c0@gmail.com', password: "poe&QuI09845k_xoP", password_confirmation: 'poe&QuI09845k_xoP')
  end

  test "user是否有效检查" do
    assert @user.valid?
  end

  # 关于模型的驱动测试已字段分类进行编写

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
    # 邮箱为空检查
    @user.email = "  "
    assert_not @user.valid?

    # 邮箱长度检查
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

    # befor_save前小写转换检查
    setup
    @user.email = 'mikeposner@163.com'
    @user.email.upcase!
    user_with_upcase_email = @user.dup
    # 下面比较报错提示通过id没有找到user,怀疑user没有保存成功,在这里加了断言确实报错,于是加上了错误返回信息,提示email已被占用,虽然喝的头疼,但至少意识还是清醒的:)
    assert @user.save, "#{@user.errors.messages}"
    assert_equal user_with_upcase_email.email.downcase, @user.reload.email

  end

  test "password_digest字段检查" do
    # 密码为空字符串检查
    @user.password = @user.password_confirmation = " "
    assert_not @user.valid?
    # 符合长度限制的空字符串检查
    @user.password = @user.password_confirmation = " " * 6
    assert_not @user.valid?
    # 非空字符串长度限制检查
    @user.password = @user.password_confirmation = "q" * 5
    assert_not @user.valid?
    # 这里原本还想加一条长度符合标准的非空字符串检查即:
      # @user.password = @user.password_confirmation = "q" * 5
      # assert @user.valid?
    # 要是这样写的话断言期望只能为true,那么这条测试无论则样都会通过,不符合测试驱动:遇红 -> 变绿 -> 重构的流程
    # 不符合这个流程,也就说明这条测试是完全没有必要的
  end

  # 集成测试中很难模拟两个不同浏览器中的操作,但这个问题的本质就是remember_digest为nil的user调用了authenticated?方法,而setup中生成的@user改属性也是为nil的
  # 在authenticated?方法中BCrypt::Password.new(remember_digest)时就已经报错了,所以传参是什么并不重要
  test "用户多浏览器登录退出问题" do
   assert_not @user.authenticated?(attribute: :remember_digest, token: '')
  end

	test 'micropost依赖关系测试' do
		@user.save
		@user.microposts.create!(content: 'should be destroyed')
		assert_difference 'Micropost.count', -1 do 
			@user.destroy
		end 
	end 

	test '关注用户测试' do
		ff4c00 = users(:ff4c00)
		bad_guy = users(:bad_guy)
		assert_not ff4c00.following?(other_user: bad_guy)
		ff4c00.follow(other_user: bad_guy)
		assert bad_guy.followers.include?(ff4c00)
		assert ff4c00.following?(other_user: bad_guy)
		ff4c00.unfollow(other_user: bad_guy)
		assert_not ff4c00.following?(other_user: bad_guy)
	end 

	
	
end
