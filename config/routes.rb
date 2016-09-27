Rails.application.routes.draw do
  root to: 'root#index'

get "/signup", to: "users#new", as: :signup

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
