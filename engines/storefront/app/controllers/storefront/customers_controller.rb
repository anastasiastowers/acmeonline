module Storefront
  class CustomersController < ApplicationController
    require 'uri'

    before_action :authenticate_customer!

    def new_subscription
      Subscription.new(*subscription_params).subscribe
    end

    private

    def subscription_params
      domain = URI(request.url).host
      [
          domain,
          params[:product],
          params[:customer_id],
          params[:credit_card][:number],
          params[:credit_card][:cvv],
          params[:credit_card][:expiration_month],
          params[:credit_card][:expiration_year],
          params[:billing][:zip_code]
      ]
    end
  end
end