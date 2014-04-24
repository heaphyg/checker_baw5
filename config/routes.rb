Rails.application.routes.draw do

  resources :users
  resources :sessions
  resources :rooms


  # post '/signup' => 'users#new'

	# get '/login' => 'sessions#new'
	# post '/login' => 'sessions#create'
	get '/logout', :controller => 'sessions', :action => 'destroy'


  # get 'index', to: :index
  root "sessions#index"
end
