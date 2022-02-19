Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "root#index"
	get '/signup', to: 'user#signup'
	post '/signup', to: 'user#create'
	get '/signin', to: 'user#signin'
	post '/signin', to: 'user#verify'
	get 'logout', to: 'user#logout'
	post '/create_article', to: 'article#create'
	patch '/update_article/:article_id', to: 'article#update'
	get '/delete_article/:article_id', to: 'article#delete'
	get '/read_article/:article_id', to: 'article#read'
	get '*path', to: 'root#index'
end
