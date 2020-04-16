Rails.application.routes.draw do
  resources :details
  resources :products
  resources :sizes
  resources :categories
  resources :photographers
  resources :order_details

  resources :customers, only: %i[create new]
  post "/login", to: "auth#login"
  get "/auto_login", to: "auth#auto_login"
  get "/user_is_authed", to: "auth#user_is_authed"

  resources :taxes
  resources :provinces
  resources :pages
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
