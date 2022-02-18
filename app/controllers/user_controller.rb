class UserController < ApplicationController
	before_action :allowed, except: [:logout]
	def signup
		@user = User.new
	end

	def create
		user = User.new(user_params)
		if user.save
			session[:user_id] = user.id
			redirect_to root_path
		else
			flash[:c_u_e]='Couldn\'t Sign up'
			redirect_to signup_path
		end
	end

	def signin
	end

	def verify
		user = User.find_by(email: params[:email])
		if user.present? && user.authenticate(params[:password])
			session[:user_id] = user.id
			redirect_to root_path
		else
			flash[:v_u_e]='Email->Password Combination Not Exist'
			redirect_to signin_path
		end
	end

	def logout
		session[:user_id]= nil
		redirect_to signin_path
	end

	def allowed
		redirect_to root_path if loggedin
	end

	private

	def user_params
		params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
