module Payments
  class Subscriber < ApplicationRecord
    has_many :subscriptions
  end
end
