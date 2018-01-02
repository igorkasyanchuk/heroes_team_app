Rails.application.routes.draw do
  root 'home#index'
  devise_for :users, path: 'account', controllers: {
    registrations: 'users/registrations'
  }

  namespace :account do
    root 'dashboard#index'
    resources :companies do
      resources :pages, only: %i[show index]
      get :download, on: :member
    end
    resources :tenants, only: %i[show index]
    resource :my_tenant, only: %i[show edit update]
    resources :users do
      post :impersonate, on: :member
      post :stop_impersonating, on: :collection
    end
  end
end
