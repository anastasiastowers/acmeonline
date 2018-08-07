module Payments
  class Subscriber < ApplicationRecord
    has_many :subscriptions, class_name: 'Payments::Subscription', foreign_key: :payments_subscriber_id

    validates :customer_id, presence: true, numericality: { only_integer: true }

    def package_details
      subscriptions_data = self.subscriptions.each_with_object({}).with_index do |(subscription, subscriptions_data), index|
        attributes = subscription.attributes
        attributes[:plan] = subscription.payments_plan.attributes
        subscriptions_data[index] = attributes
      end

      { subscriber: attributes, subscriptions: subscriptions_data }
    end
  end
end
