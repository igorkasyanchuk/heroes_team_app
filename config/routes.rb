Rails.application.routes.draw do
  root 'home#index'
  devise_for :users, path: 'account', controllers: {
    registrations: 'users/registrations'
  }

  namespace :account do
    resources :companies
    resources :pages, only: %i[show index]
    resources :tenants
    get 'profile/edit', to: 'profile#edit'
    patch 'profile/edit', to: 'profile#update'
  end
end
