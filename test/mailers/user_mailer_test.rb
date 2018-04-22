require 'test_helper'

class UserMailerTest < ActionMailer::TestCase
# 待解决: 解析邮件时遇到的编码问题
#  test "邮箱激活检查" do
#		user = users(:ff4c00)
#		user.activation_token = User.new_token	
#   mail = UserMailer.account_activation(user)
#   assert_equal "账户激活", mail.subject
#		assert_equal [user.email], mail.to
#		assert_equal [Mailer.mail_default_from], mail.from
#		# assert_match 方法不仅可以匹配字符串还可以匹配正则表达式
#		assert_match user.name, mail.body.encoded
#		assert_match user.activation_token, mail.body.encoded
#		# 在激活链接中通过GET发起请求,在查询参数(url中?后面,使用键值对形式指定,多个之间以&符号拼接)中
#		# 邮件地址的@要被转义为%40,CGI.escape方法会转义电子邮件地址
#		# 带有查询参数链接示例:
#		# https://www.baidu.com/s?wd=查询参数&rsv_spt=1&rsv_iqid=0xb99802470000816b&...
#		assert_match CGI.escape(user.email), mail.body.encoded
#  end

 end
