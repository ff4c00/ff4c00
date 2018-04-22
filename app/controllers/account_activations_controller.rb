class AccountActivationsController < ApplicationController

	def edit

  	user = User.find_by(email: params[:email])
		message = []

		(status_1 = user.present? == true) ? nil : message << [signup_path, '该账户尚不存在,请注册.']
		(status_2 = !(user.activated?) == true) ? nil : message << [login_path, '该账户已完成注册,请登录:)'] if status_1
		(status_3 = user.authenticated?(attribute: :activation_digest, token: params[:id]) == true) ? nil : message << [root_path, '激活令牌错误!'] 	if status_1

		if (status_1 && (status_2 ||= false) && status_3 ||= false)
			user.update_attribute(:activated, true)
			user.update_attribute(:activated_at, Time.now)
			log_in user
			flash[:success] = '账户激活成功!'
			redirect_to user_path
		else
			flash[:danger] = (first_message = message[0])[1]
			redirect_to first_message[0]
		end

	end 

end
