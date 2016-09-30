Rails.application.routes.draw do
  root to: 'root#index'

  resources :users
  resources :sessions
  get '/signup', to: 'users#new', as: :signup
  post '/signup' => 'users#create'
  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  get '/logout' => 'sessions#destroy', as: :logout
  get '/home' => 'users#show', as: :home


  resources :links
 get "/:vanity_string" => "links#create_vanity_string"
end
