class CreatePaymentsApiKeys < ActiveRecord::Migration[5.2]
  def change
    create_table :payments_api_keys do |t|
      t.string :name, null: false, default: ''
      t.string :token, null: false, default: ''

      t.timestamps
    end
  end
end
