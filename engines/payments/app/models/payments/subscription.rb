module Payments
  class Subscription < ApplicationRecord
    belongs_to :plan
    belongs_to :subscriber

    enum billing_frequency: [:monthly]
  end
end
