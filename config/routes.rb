Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'sessions#new'

  get '/', to: "teams#index"
  get '/signup', to: "users#new"
  get '/new_team', to: "teams#new"
  post '/new_team', to: "teams#create"
  get '/login', to: "sessions#new"
  post '/login', to: "sessions#create"
  get '/logout', to: "sessions#destroy"
  get '/index123', to: 'players#index'

  get '/players', to: 'teams#add_player'
  post '/players', to: 'teams#add_to_roster'
  post '/players_team', to: 'teams#set_data'

  post '/', to: 'teams#destroy'

  get '/stats', to: 'teams#stats'
  
  resources :teams, only: [:index, :create]
  resources :players, only: [:index]
  resources :users, only: [:create]
end
