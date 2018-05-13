class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper
	
  def logged_in_user
    unless logged_in?
      # 待实现: 记录这些违规操作的IP地址等有效信息
      store_location
      flash[:danger] = '请先登录'
      redirect_to login_path
    end
  end

end
