class SessionsController < ApplicationController

  def new
  end

  def create

    session = params[:session]
    @user = User.find_by_email(session[:email].downcase)
    bingo_password = @user&.authenticate(session[:password])

    if @user && bingo_password

      log_in(@user)
      session[:remember_me] == '1' ? remember(@user) : forget(@user)
      # user_url(user) #=> "http://localhost:4000/users/7" # 单数并以user为参数是show页面链接
      # users_url #=> "http://localhost:4000/users" # 复数是user列表页面链接
      redirect_to user_url(@user)

    elsif @user

      # 闪现消息在一个生命周期内是持续存在的,而重新渲染页面(render)不算是一次新请求
      # 所以重新新渲染页面后闪现消息在打开其他页面后仍然存在
      # flash.now专门用于在重新渲染页面中显示闪现消息
      # flash[:danger] = "密码输入有误"
      flash.now[:danger] = "密码输入有误"
      render 'new'

    elsif !@user
      flash[:danger] = "该邮箱尚未注册,完成注册即可登录"
      redirect_to signup_path
    else
      flash.now[:danger] = "很负责的告诉你这是一个bug:("
      render 'new'
    end

  end

  def destroy
    log_out if logged_in?
    redirect_to root_path
  end
end
