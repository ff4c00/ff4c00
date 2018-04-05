module SessionsHelper

  def log_in(user)
    session[:user_id] = user.id
  end

  def log_out
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
    @current_user ||= User.find_by_id(session[:user_id])
  end

  def logged_in?
    !current_user.nil?
  end

end
