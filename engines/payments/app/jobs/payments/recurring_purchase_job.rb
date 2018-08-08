module Payments
  class RecurringPurchaseJob < ApplicationJob
    queue_as :default

    def perform(subscription_id)
      @subscription = Payments::Subscription.find_by(id: subscription_id)
      return unless @subscription.active
      response = @subscription.make_payment
      # TODO: Send email to subscriber that payment was accepted

      self.perform_now
      return unless response['error_code']
      puts "Houston, we have a problem: #{response.to_json}"
      # TODO: Deactivate the subscription and let the subscriber know that something is wrong with their credit card info
    end
  end

end