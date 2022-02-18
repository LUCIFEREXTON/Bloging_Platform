class ApplicationController < ActionController::Base
	helper_method :deleted, :current_user, :loggedin
	def article_deleted(id)
		Article.find_by(id:id).nil?
	end
	def current_user
		User.find_by(id:session[:user_id])
	end

	def loggedin
		current_user.present?
	end
end
