class CreatePaymentsSubscriptions < ActiveRecord::Migration[5.2]
  def change
    create_table :payments_subscriptions do |t|
      t.string :fakepay_token, null: false, default: ''
      t.integer :billing_frequency, null: false, default: 0
      t.boolean :active, null: false, default: false

      t.timestamps
    end
  end
end
