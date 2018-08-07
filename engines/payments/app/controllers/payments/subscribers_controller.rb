module Payments
  class SubscribersController < ApplicationController
    include AuthenticationHandler

    before_action :set_subscriber
    skip_before_action :verify_authenticity_token

    def show
      response = @subscriber.package_details
      json_response(response.to_json)
    end

    private

    def set_subscriber
      @subscriber = Subscriber.eager_load(subscriptions: :payments_plan).find(params[:id])
    end
  end
end