class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      # 发送欢迎的flash信息
      flash[:success] = "注册成功,欢迎你呦:)"
      # redirect_to user_path(@user) #=> Redirected to http://localhost:4000/users/3"<html><body>You are being <a href=\"http://localhost:4000/users/3\">redirected</a>.</body></html>"
      redirect_to user_path(@user)
    else
      render 'new'
    end
  end

  def show
    @user = User.find(params[:id])
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

end
