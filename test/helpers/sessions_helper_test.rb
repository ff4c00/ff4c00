# require 'test_helper'

# class SessionsHelperTest < ActionView::TestCase

#   def setup
#     @user = users(:ff4c00)
#     remember(@user)
#   end

#   test "检查用户状态" do
#     assert_equal @user, current_user
#     assert is_logged_in?

#     setup

#     @user.update_attribute(:remember, User.digest(User.new_token))
#     assert_nil current_user
#   end

# end