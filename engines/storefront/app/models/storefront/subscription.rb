module Storefront
  class Subscription
    require 'net/http'
    require 'uri'

    HEADERS = {
        'Content-Type' => 'application/json',
        'Authorization' => "#{Rails.application.secrets.payments_api_key}"
    }

    def initialize(domain, plan_name, customer_id, card_number, cvv, expiration_month, expiration_year, zip_code)
      @domain = domain
      @plan_name = plan_name
      @customer_id = customer_id
      @card_number = card_number
      @cvv = cvv
      @expiration_month = expiration_month
      @expiration_year = expiration_year
      @zip_code = zip_code
    end

    def subscribe
      data = {
          amount: @amount,
          card_number: @card_number,
          cvv: @cvv,
          expiration_month: @expiration_month,
          expiration_year: @expiration_year,
          zip_code: @zip_code
      }

      request = Net::HTTP::Post.new(host_uri.request_uri, HEADERS)
      request.body = data.to_json
      # TODO: there's something wrong with this call. it can't make it to the payments side
      response = client.request(request)

      JSON.parse(response.body)
    end

    private

    def client
      http = Net::HTTP.new host_uri.host, 3000
      http.max_retries = 2
      http.use_ssl = false
      http
    end

    def host_uri
      url = "http://payments.#{@domain}/subscriptions"
      puts url
      URI url
    end
  end
end
