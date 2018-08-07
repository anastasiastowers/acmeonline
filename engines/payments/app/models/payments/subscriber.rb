module Payments
  class Subscriber < ApplicationRecord
    has_many :subscriptions, class_name: 'Payments::Subscription'

    validates :customer_id, presence: true, numericality: { only_integer: true }
  end
end
