Rails.application.routes.draw do
  root to: 'root#index'

  resources :users
  get '/signup' => 'users#new', as: :signup
  post '/signup' => 'users#create'
  get '/home' => 'links#index', as: :home
  resources :sessions
  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  get '/logout' => 'sessions#destroy', as: :logout

  resources :links
  get '/original_url/:id' => 'links#original_url', as: :original_url
  get '/inactive/:id' => 'links#inactive', as: :inactive
end
