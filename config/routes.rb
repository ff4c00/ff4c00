Rails.application.routes.draw do

  root 'static_pages#home'
  get '/home', to: 'static_pages#home'
  get '/help', to: 'static_pages#help'
  get '/about', to: 'static_pages#about'
  get '/test', to: 'static_pages#test'

  get '/signup', to: 'users#new'

  resources :users do 
		member do 
			get :following, :followers
		end
	end 

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

	resources :account_activations, only: [:edit]
	resources :microposts, only: [:create, :destroy, :edit, :update]
	resources :relationships, only: [:create, :destroy]


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
