Rails.application.routes.draw do
  get  '/add_company',  to: 'companies#new'
  post '/add_company',  to: 'companies#create'
  resources :companies
end
