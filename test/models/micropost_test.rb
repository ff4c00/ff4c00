require 'test_helper'

class MicropostTest < ActiveSupport::TestCase

	def setup
		@user = users(:ff4c00)
		@micropost = @user.microposts.build(content: 'content')
	end

	test 'user_id字段测试' do
		assert @micropost.valid?
		@micropost.user_id = nil
		assert_not @micropost.valid?
	end

	test 'content字段测试' do
		@micropost.content = "     "
		assert_not @micropost.valid?
		@micropost.content = "m" * (Goddess.micropost.text_length + 1)
		assert_not @micropost.valid?
	end

	test '默认作用域测试' do
		assert_equal microposts(:fine), Micropost.first
	end

	# 待处理:
	if false
	test '未登录状态下新建微博,重定向到登录页面' do
		assert_no_difference 'Micropost.count' do
			post micropost_path, params: {micropost: {content: 'should not build'}}
		end
		assert_redirected_to login_url
	end
  end

	# 待处理: 测试不识别路由
	if false
	test '未登录状态删除微博,重定向到登录页面' do
		assert_no_difference 'Micropost.count' do
			delete micropost_path(@micropost)
		end
		assert_redirected_to login_url
	end
	end

	# 待处理:
	if false
	test '用户只允许删除自己的微博' do
		log_in_as(@user)
		micropost = microposts(:together)
		asserent_no_difference 'Micropost.count' do
			delete micropost_path(micropost)
		end
		assert_redirected_to root_url
	end
  end

end
