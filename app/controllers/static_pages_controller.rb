class StaticPagesController < ApplicationController
  def home
		if logged_in?
			if params[:edit_micropost] ||= false
				@micropost = current_user.microposts.find_by_id(params[:id])
			else
				@micropost = current_user.microposts.build
			end
			@feed_items = current_user.feed.page(params[:page]).per(Goddess.paging_number)
		end 
  end

  def help
  end

  def about
  end

	def test
	end 

end
