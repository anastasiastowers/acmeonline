Storefront::Engine.routes.draw do
  devise_for :customers, class_name: "Storefront::Customer"
  root to: 'home#index'
end
