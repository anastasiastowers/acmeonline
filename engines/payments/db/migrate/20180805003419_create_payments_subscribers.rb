class CreatePaymentsSubscribers < ActiveRecord::Migration[5.2]
  def change
    create_table :payments_subscribers do |t|
      t.string :customer_id, null: false, default: ''

      t.timestamps
    end
  end
end
