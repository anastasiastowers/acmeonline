module Payments
  module AuthenticationHandler
    extend ActiveSupport::Concern

    included { before_action :verify_api_token }

    private

    def verify_api_token
      # Check if key is missing
      api_key = request.headers['HTTP_AUTHENTICATION']
      return missing_key_failure unless api_key.present?

      # Check if key is valid
      authenticated_key = Payments::ApiKey.find_by(token: api_key)
      unauthenticated_key_failure unless authenticated_key.present?
    end

    def missing_key_failure
      json_response({ error_message: 'Missing API Key', code: 'missing_api_key' }, status: 401)
    end

    def unauthenticated_key_failure
      json_response({ error_message: 'Invalid API Key', code: 'invalid_key' }, status: 401)
    end
  end
end
