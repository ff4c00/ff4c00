require 'test_helper'

class MicropostTest < ActiveSupport::TestCase
	
	def setup
		@user = users(:ff4c00)
		@micropost = Micropost.new(content: 'content', user_id: @user.id)
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

end
