require 'test_helper'

class StaticPagesControllerTest < ActionDispatch::IntegrationTest

  # setup方法会在每个测试之前自动执行.
  def setup
    @base_title = "ff4c00"
  end

  test "should get home" do
    get home_path
    assert_response :success
    assert_select "title", "home | #{@base_title}"
  end

  test "should get help" do
    get help_path
    assert_response :success
    assert_select "title", "help | #{@base_title}"
  end

  test "关于about页面的测试" do
    get about_path
    assert_response :success
    assert_select "title", "about | #{@base_title}"
  end

  test "项目跟路径" do
    get root_path
    assert_response :success
  end

end
