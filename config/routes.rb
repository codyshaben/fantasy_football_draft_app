Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'users#home'

  get '/', to: "teams#index"
  get '/signup', to: "users#new"
  get '/login', to: "sessions#new"
  post '/login', to: "sessions#create"
  get '/logout', to: "sessions#destroy"
  post '/', to: "teams#create"
  get '/index123', to: 'players#index'

  get '/players', to: 'teams#add_player'
  post '/players', to: 'teams#add_to_roster'
  post '/players_team', to: 'teams#set_data'
  
  resources :teams, only: [:index, :create]
  resources :players, only: [:index]
  resources :users, only: [:create]
end
