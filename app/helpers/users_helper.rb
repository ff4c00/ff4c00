module UsersHelper

  # 返回用户的gravatar头像
  # 全球通用识别头像,又称Gravatar,可以让用户上传图像并关联到自己的电子邮件地址上.
  def gravatar_for(user:,size: 50)
    # 头像的url需要使用用户电子邮箱的MD5哈希值
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    image_tag(gravatar_url, alt: user.name, class: 'gravatar', size: size)
  end

	def head_portrait(user:, path:)
		link_to gravatar_for(user: user), path
	end 
end

