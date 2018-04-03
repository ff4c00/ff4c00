require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest

  test "layout链接集成测试" do
    # 一个好的测试就像是在讲述一个连贯的故事一样

    # 打开首页
    get root_path

    # 检查是否包含以下目录内的模板:
    assert_template 'static_pages/home'
    assert_template 'layouts/_header'
    assert_template 'layouts/application'
    assert_template 'layouts/_footer'

    # 检查是否包含以下标签:
    # 两个地址为root_path的a标签(Rails会自动将?号替换成自定的链接)
    assert_select "a[href=?]", root_path, count: 2
    # 两个地址分别为help_path和about_path的a标签
    assert_select "a[href=?]", help_path
    assert_select "a[href=?]", about_path
    # class名为center的div标签
    assert_select "div.center"
    # id为logo内容为ff4c00的a标签
    assert_select "a#logo", text: "ff4c00"
    # 包含ff4c00的h1标签
    assert_select "h1", "ff4c00"

    # 检查页面的标题是否和application辅助方法生成的一致
    assert_select "title", full_title("首页")
    # 使用assert_equal方法(assert_equal 值一, 值二 通过"=="来判断是否一致)来检查上面内容
    assert_equal full_title("首页"), "首页 | ff4c00"
    assert_equal "首页 | ff4c00", full_title("首页")
    # 首页检查完毕

    # 打开注册页面
    get signup_path
    # 检查页面标题
    assert_select "title", full_title("用户注册")

    # 注册页检查完毕

  end

end
