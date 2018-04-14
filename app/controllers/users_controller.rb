class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update, :index, :destroy]
  before_action :correct_user, only: [:edit, :update]
	before_action :admin_user, only: :destroy

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      # session中存储user_id
      log_in(@user)
      # 发送欢迎的flash信息
      flash[:success] = "注册成功,欢迎你呦:)"
      # redirect_to user_path(@user) #=> 
			# Redirected to http://localhost:4000/users/3"
			# <html><body>You are being <a href=\"http://localhost:4000/users/3\">
			# redirected</a>.</body></html>"
      redirect_to user_path(@user)
    else
      render 'new'
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = '个人资料编辑成功!'
      # redirect_to user_path(@user)
      redirect_to @user
    else
      render 'edit'
    end
  end

  def index
		# 待优化: 分页全局调用统一方法,避免分页条数不一致,后期替换也方便
		@users = User.page(params[:page]).per(30)
  end

	def destroy
		@user = User.find(params[:id])
    if current_user?(@user)
			flash[:danger] = '禁止删除本人'
			redirect_to users_path
		else
			@user.destroy 
			flash[:success] = '用户已删除'
			redirect_to users_path
		end

	end 

  private

    def user_params
			# 健壮参数的重要意义在于:只允许通过请求传入可安全编辑的属性
			# user模型包含一个admin属性,如果没有健壮参数的限制后果就是,任何人都可以在PATCH更新请求中将某一用户设置为管理员,如:
			# patch /users/:id?admin=1
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

    def logged_in_user
      unless logged_in?
        # 待实现: 记录这些违规操作的IP地址等有效信息
        store_location
        flash[:danger] = '请先登录'
        redirect_to login_path
      end
    end

    def correct_user
      @user = User.find(params[:id])
      unless current_user?(@user)
        # 待实现: 记录这些违规操作的IP地址等有效信息
        flash[:danger] = 'Hi,Jack!'
        redirect_to root_path
      end
    end

				
		def admin_user
			redirect_to(root_path) unless current_user.admin?
		end 

end
