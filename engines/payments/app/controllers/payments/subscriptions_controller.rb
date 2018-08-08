module Payments
  class SubscriptionsController < ApplicationController
    include AuthenticationHandler

    before_action :set_subscription, only: [:show, :update]
    skip_before_action :verify_authenticity_token

    def create
      set_subscriber and set_plan

      @subscription = Subscription.new(subscription_params)
      @subscription.payments_subscriber = @subscriber
      @subscription.payments_plan = @plan

      if @subscription.valid?
        response = @subscription.make_payment
        json_response(*response)
      else
        errors = @subscription.errors.full_messages.join('. ')
        json_response({ error_message: errors, code: :invalid_subscription }, status: 400)
      end
      @subscription.save

    end

    def show
      response = @subscription.package_details
      json_response(response.to_json)
    end

    def update
      @subscription.update(subscription_params)

      if @subscription.valid?
        response = @subscription.package_details
        json_response(response.to_json)
      else
        errors = @subscription.errors.full_messages.join('. ')
        json_response({ error_message: errors, code: :invalid_subscription }, status: 400)
      end
    end

    private

    def set_subscription
      @subscription = Subscription.eager_load(:payments_plan, :payments_subscriber).find(params[:id])
    end

    def subscription_params
      params.permit(:fakepay_token, :customer_id, :card_number, :cvv, :expiration_month, :expiration_year, :zip_code)
    end

    def update_subscription_params
      params.permit(:active)
    end

    def set_subscriber
      customer_id = params[:customer_id]
      @subscriber = Subscriber.find_or_initialize_by(customer_id: customer_id)
    end

    def set_plan
      plan_name = params[:plan_name]
      @plan = Plan.find_by_name plan_name
    end
  end
end