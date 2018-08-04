Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  constraints subdomain: 'payments' do
    mount Payments::Engine => "/", as: 'payments'
  end

  mount Storefront::Engine => "/", as: 'storefront'
end
