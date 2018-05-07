class Micropost < ApplicationRecord
  belongs_to :user
	validates :user_id, presence: true
	validates :content, presence: true, length: {maximum: Goddess.micropost.text_length}

	# 我最初写这个项目的时候只是想跟着大佬一步步的把项目很多平时接触不到的基础东西学一边
	# 现在我有了其他的想法,其实要想写好或者说是具有参考价值的一篇文章和一个项目是一样的
	# 都需要去不断的去维护和修改
	# 现在几乎全部的博客平台都忽略了这一痛点
	# 一个软件或服务的安装配置步骤,gem的使用方法都会随着时间和版本的变动而发生变化
	# 而那些为了自己以及后人少踩坑所写的文章理应随之更新
	# 所以默认排序应该按照更新时间而不是创建时间来排序
	# 关于博客的内容,最终设想是实现类似代码版本控制工具那样
	# 可以展现所有的修改记录,以及其他人可以随意的fork你的文章,请求合并到你的版本
	# 就像完整的代码版本控制工具那样
	
	default_scope -> {order(updated_at: :desc)}
	
end
