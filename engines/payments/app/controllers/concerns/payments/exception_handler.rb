module Payments
  module ExceptionHandler
    extend ActiveSupport::Concern

    included do
      rescue_from ActiveRecord::RecordNotFound do |exception|
        json_response({ error_message: exception.message, code: :record_not_found }, :not_found)
      end

      rescue_from ActiveRecord::RecordInvalid do |exception|
        json_response({
            error_message: ValidationErrorsSerializer.new(exception.record).serialize,
            code: :record_invalid
        }, status: :unprocessable_entity)
      end

    end
  end
end
