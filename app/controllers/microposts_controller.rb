class MicropostsController < ApplicationController
	before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user, only: [:destroy, :edit]

	def create
		@micropost = current_user.microposts.build(micropost_params)
		if @micropost.save
			flash[:success] = '创建成功.'
			redirect_to root_url unless params[:ajax_post] ||= false
		else
			@feed_items = []
			flash[:danger] = @micropost.errors.full_messages.join(',')
			redirect_to root_url
		end
		render json: {'success' => true, 'message' => '创建成功.' } if params[:ajax_post] ||= false
	end

	def destroy
		@micropost.destroy
		flash[:success] = '微博已删除.'
		redirect_to request.referrer || root_url
	end

	def edit
		redirect_to root_url(id: params[:id],edit_micropost: true)
	end

	def update
		microposts.find(params[:id]).update(micropost_params)
		redirect_to root_url
	end

	private

		def micropost_params
			params.require(:micropost).permit(:content, :picture, :title)
		end

		def correct_user
			@micropost = current_user.microposts.find_by(id: params[:id])
			redirect_to root_url if @micropost.nil?
		end

		def microposts
			current_user.microposts
		end
end
