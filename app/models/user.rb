class User < ApplicationRecord
  validates(:name, presence: true, length: {maximum: 50})
  email_reg = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  # uniqueness 用于唯一性校验且区分大小写 case_sensitive选项用于是否区分大小写
  # 将uniqueness: true -> uniqueness: {case_sensitive: false} 即可在校验唯一性的同时不区分大小写
  # 推测: uniqueness: true 即为 uniqueness: {case_sensitive: true}的一种简写
  # 待深入: uniqueness 参数这里是怎么实现的?也就是说当case_sensitive指定为false时他是怎么指定将uniqueness为true的?
  validates(:email, presence: true, length: {maximum: 255}, format: {with: email_reg},uniqueness: {case_sensitive: false})


end
