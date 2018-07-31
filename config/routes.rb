Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  mount Storefront::Engine => "/", as: 'storefront'

  constraints subdomain: 'payments' do
    mount Payments::Engine => "/", as: 'payments'
  end
end
