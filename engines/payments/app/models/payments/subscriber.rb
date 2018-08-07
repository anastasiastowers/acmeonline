module Payments
  class Subscriber < ApplicationRecord
    has_many :subscriptions, class_name: 'Payments::Subscription', foreign_key: :payments_subscriber_id

    validates :customer_id, presence: true, numericality: { only_integer: true }

    def package_details
      subscriptions = payments_subscriptions

      {
          subscriber: attributes,
          subscriptions: {

          }
      }
    end
  end
end
