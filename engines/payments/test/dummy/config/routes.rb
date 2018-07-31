Rails.application.routes.draw do
  mount Payments::Engine => "/payments"
end
