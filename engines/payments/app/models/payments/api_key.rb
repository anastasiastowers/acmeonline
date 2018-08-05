module Payments
  class ApiKey < ApplicationRecord
    has_secure_token :token

    # after_create generate_token
    # attr_accessor :name, :token

    private

    # def generate_token
    #   token = SecureRandom.urlsafe_base64
    #   self.update(token: token)
    # end
  end
end
