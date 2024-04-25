Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'
  resources :warehouses, only: [:show, :new, :create, :edit, :update, :destroy]
  resources :suppliers, only: [:index, :show, :new, :create, :edit, :update]
  resources :product_models, only: [:index, :show, :new, :create]

  #resources :orders, only: [:new, :create, :show]
  # rota personalizada
  #get 'buscar-pedido', to: 'orders#search'    #=> buscar_pedido GET    /buscar-pedido(.:format)       orders#search
  resources :orders, only: [:new, :create, :show, :index] do
    get 'search', on: :collection     #=> search_orders GET    /orders/search(.:format)       orders#search
  end
  
  #authenticate :user do
  #  resources :product_models, only: [:index, :new, :create, :show]
  #end
end
