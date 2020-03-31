Rails.application.routes.draw do
  resources :order_details
  resources :customers
  resources :taxes
  resources :provinces
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  resources :pages
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
