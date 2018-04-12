require 'test_helper'

class UsersIndexTest < ActionDispatch::IntegrationTest

	def setup
		@user = users(:ff4c00)
	end 

	test '列表页面检查' do
	
		log_in_as(@user)
		get users_path
		assert_template 'users/index'
		assert_select 'ul.users'
		User.page(1).per(30).each do |user|
			assert_select 'a[href=?]', user_path(user), text: user.name
		end

	end 

end

