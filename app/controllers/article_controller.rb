class ArticleController < ApplicationController
	before_action :authenticate_user!
	def create
		article = Article.new(:title => params[:title], :body => params[:body, :user_id => params[:user_id]])
		if article.save
			flash[:success] = 'Article Created'
			redirect_to root_path
		else
			flash[:error] = 'Article Creation Failed'
			redirect_to root_path
		end
	end

	def read
		@article = Article.find_by(:id => params[:article_id])
		redirect_to root_path if @article.nil?
	end

	def update
		article = Article.find_by(:id => params[:article_id])
		redirect_to root_path if article.nil?
		if article.update(:title => params[:title], :body => params[:body, :user_id => params[:user_id]])
			flash[:success] = 'Article Updated'
			redirect_to "/read_article/#{ article.id }"
		else
			flash[:error] = 'Update failed'
			redirect_to "read-article/#{ article.id }"
		end
	end

	def delete
		article = Article.find_by(:id => params[:article_id])
		redirect_to root_path if article.nil?
		if article&.destroy&.present?
			flash[:success] = 'Article Deleted'
			redirect_to root_path
		else
			flash[:error] = 'Article Not deleted'
			redirect_to "/read_article/#{ params[:article_id] }"
		end
	end
end
