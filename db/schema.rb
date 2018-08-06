# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2018_08_05_214323) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "payments_api_keys", force: :cascade do |t|
    t.string "name", default: "", null: false
    t.string "token", default: "", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "payments_plans", force: :cascade do |t|
    t.string "name"
    t.string "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "payments_subscribers", force: :cascade do |t|
    t.string "customer_id", default: "", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "payments_subscriptions", force: :cascade do |t|
    t.string "fakepay_token", default: "", null: false
    t.integer "billing_frequency", default: 0, null: false
    t.boolean "active", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "payments_subscriber_id"
    t.bigint "payments_plan_id"
    t.index ["payments_plan_id"], name: "index_payments_subscriptions_on_payments_plan_id"
    t.index ["payments_subscriber_id"], name: "index_payments_subscriptions_on_payments_subscriber_id"
  end

  create_table "storefront_customers", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "name"
    t.string "address_1"
    t.string "address_2"
    t.string "city"
    t.string "state"
    t.string "zip_code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_storefront_customers_on_email", unique: true
    t.index ["reset_password_token"], name: "index_storefront_customers_on_reset_password_token", unique: true
  end

  add_foreign_key "payments_subscriptions", "payments_plans"
  add_foreign_key "payments_subscriptions", "payments_subscribers"
end
