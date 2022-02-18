class ArticleController < ApplicationController
	before_action :authenticate_user!
	def create
		article = Article.new(article_params)
		if article.save
			flash[:c_a_s]='Article Created'
			redirect_to root_path
		else
			flash[:c_a_e]='Article Creation Failed'
			redirect_to root_path
		end
	end

	def read
		@article = Article.find_by(id:params[:article_id])
		redirect_to root_path if @article.nil?
	end

	def update
		article = Article.find_by(id:params[:article_id])
		if article.update(article_params)
			flash[:u_a_s]='Article Updated'
			redirect_to "/read_article/#{article.id}"
		else
			flash[:u_a_e]='Update failed'
			redirect_to "read-article/#{article.id}"
		end
	end

	def delete
		article = Article.find_by(id:params[:article_id])
		article.destroy
		if article_deleted(params[:article_id])
			flash[:d_a_s]= 'Article Deleted'
			redirect_to root_path
		else
			flash[:d_a_e]='Article Not deleted'
			redirect_to "/read_article/#{:article_id}"
		end
	end

	private

	def article_params
		params.require(:article).permit(:title, :body, :user_id)
	end
end
