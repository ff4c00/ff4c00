class User < ApplicationRecord

	has_many :microposts

  # name字段
  # 待优化: 对name字段进行限制,不允许包含:admin,root,king,queen,fuxi,ff4c00,该用户已注销等保留字
  validates(:name, presence: true, length: {maximum: 50})
  # name字段 end

  # email字段
  # uniqueness 用于唯一性校验且区分大小写 case_sensitive选项用于是否区分大小写
  # 将uniqueness: true -> uniqueness: {case_sensitive: false} 即可在校验唯一性的同时不区分大小写
  # 推测: uniqueness: true 即为 uniqueness: {case_sensitive: true}的一种简写
  # 待深入: uniqueness 参数这里是怎么实现的?也就是说当case_sensitive指定为false时他是怎么指定将uniqueness为true的?
  # 待优化: 搭建一个邮箱系统
	validates(:email, presence: true, length: {maximum: 255}, format: {with: eval(Goddess.user.reg_email)},uniqueness: {case_sensitive: false})
  before_save  :downcase_email
	# email字段 end

  # password字段

  # 身份验证
  # 验证身份的方法是:获取用户提交的密码,计算密码哈希摘要,与数据库中存储的密码哈希值对比.用于对比的是密码哈希值,而不是原始密码.
  # gem bcrypt提供的一个方法:has_secure_password,使用bcrypt哈希算法计算密码摘要(需要在数据库添加string类型的password_digest字段)
  # 哈希算法计算密码摘要与加密的不同之处在于:加密是可逆的即能加密就能解密,而计算密码哈希摘要的目的是实现不可逆,由摘要很难推算出原始密码
  # 在模型中添加这个方法后会自动添加如下功能:
    # 在数据库的password_digest列存储安全的密码哈希值
    # 获得一对虚拟属性:password和password_confirmation,而且创建用户对象时会执行存在性验证和匹配验证(只会验证有没有密码,但不会验证'   '这样的无效密码,需要在该字段的验证中加入: presence: true进行限制).
    # authenticate方法,由于验证用户输入密码和数据库中的密码哈希值是否一致,不同返回false,一致返回该user对象(可以用!!将其结果转为true或false)
  # 推测: 获得的这对虚拟属性是不是使用的ActiveRecord::Store对password_digest字段作为序列化的封装?
  # 推测: 用authenticate方法应该可以撞库,从而得到原始密码.
  # 待优化: 引入第三方登录如:ruby-china,github,微信,QQ等.
  has_secure_password
  # 身份验证 end

  # password字段验证
  # 待优化: 对密码进行更多限制已增强密码强度,如:必须包含英文大小写,数字和特殊符号
  validates(:password, length: {minimum: 6}, presence: true, allow_nil: true)
  # password字段验证 end

  # password字段 end

	# 记住用户
	# 虚拟属性
  attr_accessor :remember_token



  # 返回指定字符串的哈希摘要
  def self.digest(string)
    # cost是耗时因子,决定计算哈希值时消耗的资源,耗时因子的值越大,由哈希值破解出原密码的难度越大
    # 这行代码的作用是在测试时使用最小值,生产环境使用普通值
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost

    BCrypt::Password.create(string, cost: cost)
  end

  def self.new_token
    # Ruby标准库中SecureRandom模块的urlsafe_base64方法用于返回长度为22位的随机字符串
    # 包含A-Z,a-z,0-9,_,-,即每一位都有64中可能
    SecureRandom.urlsafe_base64
  end

  # 数据库存储记忆令牌的哈希摘要
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  # 忘记用户时将数据库中记忆令牌的哈希摘要清空
  def forget
    update_attribute(:remember_digest, nil)
  end
	
	# 记住用户 end 
	
	# 账户激活
	attr_accessor :activation_token

	before_create :create_activation_digest
	
	
	
	# 账户激活 end

  # 我个人比较喜欢用关键字传参,这样无论是可扩展性还是可读性都非常的高
  def authenticated?(attribute:, token:)
    # 2.3.0 :004 > remember_digest = user.remember_digest
    #  => "$2a$10$w47m6xTLo5pfVGOWGZGrtOVEY8D5/bGYYybi78DGdEsfeUHKIHG7q"
    # 2.3.0 :005 > BCrypt::Password.new(remember_digest)
    #  => "$2a$10$w47m6xTLo5pfVGOWGZGrtOVEY8D5/bGYYybi78DGdEsfeUHKIHG7q"
    # 待深入: 这里new一下只是为了获得is_password?方法? 随便new一个值会报错,有点反应不过来了,傻了傻了...

		# send 方法的作用是在指定对象上调用指定的方法,如: 
		# 2.3.0 :006 > a = [1,2,3,4,5,6,7]
    #  => [1, 2, 3, 4, 5, 6, 7]
    # 2.3.0 :007 > a.length
    #  => 7
    # 2.3.0 :008 > a.send(:length)
    #  => 7
    # 2.3.0 :009 > a.send('length')
    #  => 7
    # 无论传参为符号还是字符串,插值的时候都会转为字符串 
		digest = self.send(attribute)

    return false if token.blank?
    BCrypt::Password.new(digest).is_password?(token) #或者rescue false
  end

	private

		def downcase_email
			self.email = self.email.downcase
		end

		def create_activation_digest
			self.activation_token = User.new_token
			self.activation_digest = User.digest(self.activation_token)
		end 

end
