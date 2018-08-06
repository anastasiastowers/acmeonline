module Payments
  class Plan < ApplicationRecord
    has_many :subscriptions
  end
end
