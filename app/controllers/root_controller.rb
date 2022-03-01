class RootController < ApplicationController
	def index
		@articles = Article.all
		@article = Article.new
	end
end
