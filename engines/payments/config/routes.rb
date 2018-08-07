Payments::Engine.routes.draw do
  root to: 'home#index'

  resources :subscriptions, only: [:create, :show, :update]
  resources :subscribers, only: [:show]
end
