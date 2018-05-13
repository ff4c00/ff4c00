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
			UserMailer.account_activation(@user).deliver_now
      flash[:info] = '请检查邮箱,根据激活邮件提示,完成账户激活:)'
      redirect_to root_path
    else
      render 'new'
    end
  end

  def show
    @user = User.find(params[:id])
		@microposts = @user.microposts.page(params[:page]).per(Goddess.paging_number)

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
		@users = User.where(activated: true).page(params[:page]).per(Goddess.paging_number)
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
