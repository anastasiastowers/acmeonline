module Payments
  class Fakepay
    require 'net/http'
    require 'uri'

    BASE_URL = 'https://www.fakepay.io'
    HEADERS = {
        'Content-Type' => 'application/json',
        'Authorization' => "Token token=#{Rails.application.secrets.fakepay_API_key}"
    }

    attr_accessor :amount, :fakepay_token, :card_number, :cvv, :expiration_month, :expiration_year, :zip_code

    def initialize(fakepay_token: nil, amount: '', card_number: '', cvv: '', expiration_month: '', expiration_year: '', zip_code: '')
      @amount = amount
      @fakepay_token = fakepay_token
      @card_number = card_number
      @cvv = cvv
      @expiration_month = expiration_month
      @expiration_year = expiration_year
      @zip_code = zip_code
    end

    def purchase
      data = if @fakepay_token
                {
                    amount: @amount,
                    token: @fakepay_token
                }
             else
               {
                   amount: @amount,
                   card_number: @card_number,
                   cvv: @cvv,
                   expiration_month: @expiration_month,
                   expiration_year: @expiration_year,
                   zip_code: @zip_code
               }
             end

      request = Net::HTTP::Post.new(host_uri.request_uri, HEADERS)
      request.body = data.to_json
      response = client.request(request)

      JSON.parse(response.body)
    end

    private

    def client
      http = Net::HTTP.new host_uri.host, host_uri.port
      http.max_retries = 2
      http.use_ssl = true
      http
    end

    def host_uri
      url = "#{BASE_URL}/purchase"
      URI url
    end
  end
end
