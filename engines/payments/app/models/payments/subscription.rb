module Payments
  class Subscription < ApplicationRecord
    belongs_to :payments_plan, class_name: 'Payments::Plan'
    belongs_to :payments_subscriber, class_name: 'Payments::Subscriber'

    FAKEPAY_ERRORS = {
        '1000001' => 'Invalid credit card number',
        '1000002' => 'Insufficient funds',
        '1000003' => 'CVV failure',
        '1000004' => 'Expired card',
        '1000005' => 'Invalid zip code',
        '1000006' => 'Invalid purchase amount',
        '1000007' => 'Invalid token'
    }

    attr_accessor :amount, :customer_id, :card_number, :cvv, :expiration_month, :expiration_year, :zip_code

    enum billing_frequency: [:monthly]

    validates :billing_frequency, presence: true, inclusion: { in: billing_frequencies.keys }
    validates_inclusion_of :active, in: [true, false]

    validates :customer_id, presence: true, if: :new_record?

    validates :fakepay_token, presence: true, unless: :credit_card_present?

    validates :card_number, presence: true, unless: :fakepay_token_present?
    validates :cvv, presence: true, unless: :fakepay_token_present?
    validates :expiration_month, presence: true, unless: :fakepay_token_present?
    validates :expiration_year, presence: true, unless: :fakepay_token_present?
    validates :zip_code, presence: true, unless: :fakepay_token_present?

    def fakepay_token_present?
      self.fakepay_token.present?
    end

    def credit_card_present?
      self.card_number.present?
    end

    def package_details
      {
          plan: {
            id: payments_plan.id,
            name: payments_plan.name,
            price: payments_plan.price
          },
          subscriber: {
            id: payments_subscriber.id,
            customer_id: payments_subscriber.customer_id,
          },
          subscription: attributes
      }
    end

    def make_payment
      self.amount = self.payments_plan.price

      fakepay = Fakepay.new **payment_data

      response = fakepay.purchase

      if response['success']
        self.update(fakepay_token: response['token'])
        RecurringPurchaseJob.set(wait_until: next_billing_date).perform_later(self.id)
        package = self.package_details
        [ package.to_json ]
      else
        code = response['error_code']
        self.errors.details[:credit_card] = [{ error: :invalid }]
        self.errors.messages[:credit_card] = [FAKEPAY_ERRORS[code.to_s]]

        errors = self.errors.full_messages.join('. ')
        [ { error_message: errors, code: :invalid_credit_card }, status: 400 ]
      end
    end

    private

    def payment_data
      {
          fakepay_token: self.fakepay_token,
          amount: self.amount,
          card_number: self.card_number,
          cvv: self.cvv,
          expiration_month: self.expiration_month,
          expiration_year: self.expiration_year,
          zip_code: self.zip_code
      }
    end

    def next_billing_date
      frequency_map = { monthly: 'month', daily: 'day' }
      time_unit = frequency_map[self.billing_frequency.to_sym]
      1.send(time_unit).from_now
    end

  end
end
