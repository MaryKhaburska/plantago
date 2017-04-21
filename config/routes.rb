Rails.application.routes.draw do
  devise_for :users, path: '', path_names: { sign_in: 'login', sign_out: 'logout', sign_up: 'register', edit: 'settings' }
  
  resources :apparats do
    member do
      patch :update_description
    end
  end
  
  resources :users do
    resources :apparats_permits, only: [:create, :update, :destroy]
    resources :companies_permits, only: [:create, :update, :destroy]
  end
  
  resources :companies do
    resources :contacts 
  end
  
  root to: "home#index"
end
