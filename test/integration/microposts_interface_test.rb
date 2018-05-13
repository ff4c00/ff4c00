require 'test_helper'

class MicropostsInterfaceTest < ActionDispatch::IntegrationTest

	def setup
		@user = users(:ff4c00)
	end

	test '个人微博动态页面测试' do
		log_in_as(@user)
		get root_path
		assert_select 'input[type=file]'

		# 提交无效微博
		assert_no_difference 'Micropost.count' do
			post microposts_path, params: {micropost: {content: ''}}
		end
		# 待处理:
    # assert_select "div.alert-danger"

		# 有效提交
		content = 'should be right'
		picture = fixture_file_upload('test/fixtures/fuchsi.jpg', 'image/jpg')
		assert_difference 'Micropost.count' do
			post microposts_path, params: {micropost: {content: content, picture: picture}}
		end

		assert assigns(:micropost).picture?
		assert_redirected_to root_url
		follow_redirect!
		assert_match content, response.body

		# 待处理:
		if false
		# 删除测试
		assert_select 'a', text: '删除'
		first_micropost = @user.microposts.page(1).per(Goddess.paging_number)
		assert_difference 'Micropost.count', -1 do
			delete micropost_path(first_micropost)
		end
		end

		# 查看其他用户页面
		get user_path(users(:bad_guy))
		assert_select 'a', text: '删除', count: 0

	end
end
