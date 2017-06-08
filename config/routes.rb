Rails.application.routes.draw do
  devise_for :users, path: '', path_names: { sign_in: 'login', sign_out: 'logout' }
  
  resources :apparats do
    member do
      patch :update_description
      post :add_contact
      patch :remove_contact
    end
  end
  patch "/goto", to: "apparats#goto"
  
  resources :users do
    resources :apparats_permits, only: [:create, :update, :destroy]
    resources :companies_permits, only: [:create, :update, :destroy]
  end
  
  resources :companies do
    resources :contacts, except: [:index] 
  end
  
  root to: "home#index"
end
