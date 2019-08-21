Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'users#home'

  get '/', to: "teams#index"
  get '/signup', to: "users#new"
  get '/login', to: "sessions#new"
  post '/login', to: "sessions#create"
  get '/logout', to: "sessions#destroy"
  post '/', to: "teams#create"

  get '/players', to: 'teams#add_player'
  
  resources :teams, only: [:index, :create]
  resources :players, only: [:index]
  resources :users, only: [:create]
end
