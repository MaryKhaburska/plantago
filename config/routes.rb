Rails.application.routes.draw do
  devise_for :users, path: '', path_names: { sign_in: 'login', sign_out: 'logout', sign_up: 'register', edit: 'settings' }
  resources :apparats
  resources :users
  resources :companies
  root to: "home#index"
  resources :apparats_permits, only: [:create, :update, :destroy]
  resources :companies_permits, only: [:create, :update, :destroy]
end
