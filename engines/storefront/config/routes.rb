Storefront::Engine.routes.draw do
  root to: 'home#index'

  devise_for :customers, class_name: 'Storefront::Customer', module: :devise, skip: [:sessions, :registrations]
  as :customer do
    get    'login', to: 'customers/sessions#new', as: :new_customer_session
    post   'signin', to: 'customers/sessions#create', as: :customer_session
    match  'signout', to: 'customers/sessions#destroy', as: :destroy_customer_session, via: Devise.mappings[:customer].sign_out_via

    get    'register' => 'customers/registrations#new', as: :new_customer_registration
    post   'register' => 'customers/registrations#create', as: :customer_registration
    get    'confirmation_sent'  => 'customers/registrations#confirmation', as: :confirmation_sent
    put    'signup'  => 'customers/registrations#update', as: :update_customer_registration
    get    'account' => 'customers/registrations#edit',   as: :edit_customer_registration
  end

  get 'checkout', to: 'home#checkout'
end
