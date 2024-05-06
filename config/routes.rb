Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'
  resources :warehouses, only: [:show, :new, :create, :edit, :update, :destroy] do
    resources :stock_product_destinations, only: [:create]
  end
  resources :suppliers, only: [:index, :show, :new, :create, :edit, :update]
  resources :product_models, only: [:index, :show, :new, :create]

  #resources :orders, only: [:new, :create, :show]
  # rota personalizada
  #get 'buscar-pedido', to: 'orders#search'    #=> buscar_pedido GET    /buscar-pedido(.:format)       orders#search
  resources :orders, only: [:new, :create, :show, :index, :edit, :update] do
    resources :order_items, only: [:new, :create]   #=> NEW -->  /orders/:order_id/order_items/new
    get 'search', on: :collection     #=> search_orders GET    /orders/search(.:format)       orders#search
    post 'delivered', on: :member #=> on member pois é referente a um único pedido. /// POST /orders/:id/delivered
    post 'canceled', on: :member
  end
  
  #resources :order_items, only: [:new, :create]  #=> vamos aninhá-la a orders

  #authenticate :user do
  #  resources :product_models, only: [:index, :new, :create, :show]
  #end

  namespace :api do # O namespace engloba algumas rotas em volta de um nome que deve ser refletido no nome do controller
    namespace :v1 do
      resources :warehouses, only: [:show]  # api_v1_warehouse GET    /api/v1/warehouses/:id(.:format)    api/v1/warehouses#show
    end
  end
end
