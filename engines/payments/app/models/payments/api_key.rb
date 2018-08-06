module Payments
  class ApiKey < ApplicationRecord
    has_secure_token :token
  end
end
