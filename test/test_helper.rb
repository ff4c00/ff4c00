ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'minitest/reporters'
Minitest::Reporters.use!

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # application辅助文件引入测试辅助文件后可以在测试时使用application辅助文件中的方法
  include ApplicationHelper

  # 判断用户是否登录
  def is_logged_in?
    !session[:user_id].nil?
  end
end
