module SessionsHelper

  def log_in(user)
    session[:user_id] = user.id
  end

  def log_out
    forget(current_user)
    session.delete(:user_id)
    @current_user = nil
  end

  def current_user
    # 如果用户id不存在,find方法会抛出异常,find_by方法会返回nil
    # 2.3.0 :021 >   User.find_by_id(3)
    #   User Load (0.4ms)  SELECT  "users".* FROM "users" WHERE "users"."id" = ? LIMIT ?  [["id", 3], ["LIMIT", 1]]
    # => nil
    # 2.3.0 :022 > User.find(3)
    #   User Load (0.1ms)  SELECT  "users".* FROM "users" WHERE "users"."id" = ? LIMIT ?  [["id", 3], ["LIMIT", 1]]
    # ActiveRecord::RecordNotFound: Couldn't find User with 'id'=3
    # .
    # .
    # .
    # .
    if (user_id = session[:user_id])
      @current_user ||= User.find_by_id(user_id)
    # cookie.signed[:user_id]会自动解密cookie中的用户id
    else (user_id = cookies.signed[:user_id])
      user = User.find_by_id(user_id)
      if user && user.authenticated?(cookies[:remember_token])
        log_in(user)
        @current_user = user
      end
    end

  end

  def logged_in?
    !current_user.nil?
  end

  def remember(user)
    user.remember
    # 创建持久会话的方法是把签名及加密后的用户id和记忆令牌作为持久cookie存入浏览器(session_help中操作)登录时与数据库中存储的令牌哈希摘要进行确认(user模型中操作)
    # 一般签名和加密是两个不同操作,单从Rails4开始,signed方法默认既签名又加密
    # cookie可以视作一个散列,一个是value,另一个是可选的expires(过期时间)
    # Rails应用经常使用20年过期的cookie(make茅台),permanent就是用来创建过期时间为20年后的方法
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end

  def forget(user)
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end

end
