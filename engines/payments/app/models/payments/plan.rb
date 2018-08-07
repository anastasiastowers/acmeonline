module Payments
  class Plan < ApplicationRecord
    has_many :payments_subscriptions, class_name: 'Payments::Subscription', foreign_key: :payments_plan_id

    validates :name, presence: true
    validates :price, presence: true, format: { with: /\A\d+(?:\.\d{0,2})?\z/ }
  end
end
