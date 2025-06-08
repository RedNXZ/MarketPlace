Rails.application.routes.draw do
  devise_for :users

  root 'products#index'

  resources :categories, only: [:index, :show, :new, :create, :destroy] do
    collection do
      get :delete
    end
  end
  resources :products

  resources :orders, only: [:index, :show, :new, :create]

  resource :cart, only: [:show], controller: 'cart' do
    post 'add/:product_id', to: 'cart#add', as: 'add_to'
    delete 'remove/:product_id', to: 'cart#remove', as: 'remove_from'
  end

  get "up" => "rails/health#show", as: :rails_health_check
end