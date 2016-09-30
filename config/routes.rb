Rails.application.routes.draw do
  root to: 'root#index'

  resources :users
  get '/signup' => 'users#new', as: :signup
  post '/signup' => 'users#create'
  get '/home' => 'users#show', as: :home
  resources :sessions
  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  get '/logout' => 'sessions#destroy', as: :logout

  resources :links
 get "/:vanity_string" => "links#create_vanity_string"
end
