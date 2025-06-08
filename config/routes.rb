Rails.application.routes.draw do
  get "orders/new"
  get "orders/create"
  get "orders/show"
  devise_for :users
  root 'products#index'

  resources :categories, only: [:index, :show]
  resources :products
  resources :orders, only: [:new, :create, :show]
  resources :orders, only: [:new, :create]
  resources :orders, only: [:index, :show, :new, :create]

  resource :cart, only: [:show], controller: 'cart' do
    post 'add/:product_id', to: 'cart#add', as: 'add_to'
    delete 'remove/:product_id', to: 'cart#remove', as: 'remove_from'
  end

  get "up" => "rails/health#show", as: :rails_health_check
end