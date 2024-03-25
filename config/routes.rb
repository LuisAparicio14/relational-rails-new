Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
  get '/consoles', to: 'consoles#index'
  get '/consoles/new', to: 'consoles#new'
  post '/consoles', to: 'consoles#create'
  get '/consoles/:id', to: 'consoles#show'
  get '/consoles/:id/edit', to: 'consoles#edit'
  patch '/consoles/:id', to: 'consoles#update'
  delete '/consoles/:id', to: 'consoles#destroy'

  get '/games', to: 'games#index'
  get '/games/:id', to: 'games#show'
  get '/games/:id/edit', to: 'games#edit'
  patch '/games/:id', to: 'games#update'
  delete '/games/:id', to: 'games#destroy'

  get '/consoles/:id/games', to: 'console_games#index'
  get '/consoles/:id/games/new', to: 'console_games#new'
  post '/consoles/:id/games', to: 'console_games#create'
end
