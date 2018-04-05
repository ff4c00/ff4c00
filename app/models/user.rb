class User < ApplicationRecord
  # name字段
  # 待优化: 对name字段进行限制,不允许包含:admin,root,king,queen,fuxi,ff4c00,该用户已注销等保留字
  validates(:name, presence: true, length: {maximum: 50})
  # name字段 end

  # email字段
  email_reg = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  # uniqueness 用于唯一性校验且区分大小写 case_sensitive选项用于是否区分大小写
  # 将uniqueness: true -> uniqueness: {case_sensitive: false} 即可在校验唯一性的同时不区分大小写
  # 推测: uniqueness: true 即为 uniqueness: {case_sensitive: true}的一种简写
  # 待深入: uniqueness 参数这里是怎么实现的?也就是说当case_sensitive指定为false时他是怎么指定将uniqueness为true的?
  # 待优化: 搭建一个邮箱系统
  validates(:email, presence: true, length: {maximum: 255}, format: {with: email_reg},uniqueness: {case_sensitive: false})
  before_save {self.email = self.email.downcase}
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
  validates(:password, length: {minimum: 6}, presence: true)
  # password字段验证 end


  # password字段 end

  # 返回指定字符串的哈希摘要
  def self.digest(string)
    # cost是耗时因子,决定计算哈希值时消耗的资源,耗时因子的值越大,由哈希值破解出原密码的难度越大
    # 这行代码的作用是在测试时使用最小值,生产环境使用普通值
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost

    BCrypt::Password.create(string, cost: cost)
  end



end
