require 'test_helper'

class UsersIndexTest < ActionDispatch::IntegrationTest

	def setup
		@user = users(:ff4c00)
		@bad_guy = users(:bad_guy)
	end 

	def login_and_check_index_template(user:, &block)
		log_in_as(user)
		get users_path
		assert_template 'users/index'
		assert_select 'ul.users'
		yield if block
	end

	def user_count_change(count:-1,user:)
		assert_difference 'User.count', count do 
			delete user_path(user)
		end 

	end 

	test '列表页面检查' do
		login_and_check_index_template(user: @user) do 
			User.page(1).per(30).each do |user|
				assert_select 'a[href=?]', user_path(user), text: user.name
			end
		end

	end 

	# 集成测试讲究的是模拟用户在前台页面真实的操作流程
	# 而其他测试,如控制器的讲究的是针对控制器中可能出现的非法操作,如未登录及没有操作权限等
	# 去进行预防,强调的是对具体某段代码的测试,而集成测试则是对诸多段代码组成的功能进行整体流程上及测试
	# 在测试方法编写上我倾向于:
	# 模型上: 一个字段编写一个测试方法
	# 控制器: 一个动作,一个权限限制正常与非法的编写一个测试方法
	# 集成测试: 一个流程编写一个测试方法,如管理员和非管理员的操作流程单独写
	# 在重复代码的问题上,一段代码在第二次使用时必须进行重构,调用重构后的方法
	# 之前写的有点乱,以后按照上述原则来
	test '管理员用户列表页面检查' do 

		login_and_check_index_template(user: @user) do 
			User.page(1).per(30).each do |user|
				check_a_label(url:user_path(user), text: user.name)
				unless user == @user
					check_a_label(url: user_path(user), text:'删除用户')
				end 
			end
		end

 		user_count_change(user: @bad_guy)
		# 低层命令直接向控制器发送HTTP请求,不允许管理员删除自己
 	  user_count_change(count: 0, user: @user)

	end 

	test '普通用户列表页面检查' do 

		login_and_check_index_template(user: @bad_guy) do 
			User.page(1).per(30).each do |user|
				check_a_label(url:user_path(user), text: user.name)
				check_a_label(url: user_path(user), text:'删除用户',count: 0)
			end
		end

 		user_count_change(user: @bad_guy, count: 0)

	end 

end

