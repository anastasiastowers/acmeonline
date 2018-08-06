class AddPlanToSubscription < ActiveRecord::Migration[5.2]
  def change
    add_reference :payments_subscriptions, :payments_plan, foreign_key: true
  end
end
