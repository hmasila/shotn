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
  get '/error/:vanity_string' => 'links#error', as: :error
  get ':vanity_string' => 'links#original_url', as: :original_url
end
