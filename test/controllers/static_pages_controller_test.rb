require 'test_helper'

class StaticPagesControllerTest < ActionDispatch::IntegrationTest

  # setup方法会在每个测试之前自动执行.
  def setup
    @base_title = "ff4c00"
  end

  test "should get home" do
    get static_pages_home_url
    assert_response :success
    assert_select "title", "home | #{@base_title}"
  end

  test "should get help" do
    get static_pages_help_url
    assert_response :success
    assert_select "title", "help | #{@base_title}"
  end

  test "关于about页面的测试" do
    get static_pages_about_url
    assert_response :success
    assert_select "title", "about | #{@base_title}"
  end

end
