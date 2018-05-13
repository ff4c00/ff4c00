class StaticPagesController < ApplicationController
  def home
		if logged_in?
			@micropost = current_user.microposts.build
			@feed_items = current_user.feed.page(params[:page]).per(Goddess.paging_number)
		end 
  end

  def help
  end

  def about
  end
end
