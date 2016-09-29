Rails.application.routes.draw do
  root to: 'root#index'

  get '/signup', to: 'users#new', as: :signup
  post '/signup' => 'users#create'
  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  get '/logout' => 'sessions#destroy', as: :logout
  get '/home' => 'users#home', as: :home

  resources :users
  resources :sessions
  resources :links

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
