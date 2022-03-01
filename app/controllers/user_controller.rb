class UserController < ApplicationController
	before_action :allowed, except: [:logout]
	def signup
		@user = User.new
	end

	def create
		user = User.new(:email => params[:email], :password => params[:password], :password_confirmation: params[:password_confirmation])
		if user.save
			session[:user_id] = user.id
			redirect_to root_path
		else
			flash[:error] = 'Couldn\'t Sign up'
			redirect_to signup_path
		end
	end

	def signin
	end

	def verify
		user = User.find_by(:email => params[:email])
		if user.present? && user.authenticate(params[:password])
			session[:user_id] = user.id
			redirect_to root_path
		else
			flash[:error] = 'Email->Password Combination Not Exist'
			redirect_to signin_path
		end
	end

	def logout
		session[:user_id] = nil
		redirect_to signin_path
	end

	def allowed
		redirect_to root_path if user_signed_in?
	end
end
