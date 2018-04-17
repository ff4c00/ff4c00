class UserMailer < ApplicationMailer

  def account_activation(user)
    @greeting = "Hi"
		@user = user
		# mail方法还可以接受subject参数来指定邮件的主题
		mail to: user.email, subject: '账户激活' 
  end

  def password_rest
    @greeting = "Hi"

    mail to: "to@example.org"
  end
end
