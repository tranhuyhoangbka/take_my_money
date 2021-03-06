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

ActiveRecord::Schema.define(version: 2019_09_29_080138) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string "namespace"
    t.text "body"
    t.string "resource_type"
    t.bigint "resource_id"
    t.string "author_type"
    t.bigint "author_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id"
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace"
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id"
  end

  create_table "addresses", force: :cascade do |t|
    t.string "address_1"
    t.string "address_2"
    t.string "city"
    t.string "state"
    t.string "zip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "affiliates", force: :cascade do |t|
    t.string "name"
    t.integer "user_id"
    t.string "country"
    t.string "stripe_id"
    t.string "tag"
    t.json "verification_needed"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "day_revenues", force: :cascade do |t|
    t.date "day"
    t.integer "ticket_count"
    t.integer "price"
    t.integer "discounts"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer "priority", default: 0, null: false
    t.integer "attempts", default: 0, null: false
    t.text "handler", null: false
    t.text "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string "locked_by"
    t.string "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["priority", "run_at"], name: "delayed_jobs_priority"
  end

  create_table "discount_codes", force: :cascade do |t|
    t.string "code"
    t.integer "percentage"
    t.text "description"
    t.integer "minimum_amount"
    t.integer "maximum_discount"
    t.integer "max_uses"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "events", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.string "image_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_events_on_deleted_at"
  end

  create_table "payment_line_items", force: :cascade do |t|
    t.bigint "payment_id"
    t.string "buyable_type"
    t.bigint "buyable_id"
    t.float "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "original_line_item_id"
    t.bigint "administrator_id"
    t.integer "refund_status", default: 0
    t.index ["administrator_id"], name: "index_payment_line_items_on_administrator_id"
    t.index ["buyable_type", "buyable_id"], name: "index_payment_line_items_on_buyable_type_and_buyable_id"
    t.index ["original_line_item_id"], name: "index_payment_line_items_on_original_line_item_id"
    t.index ["payment_id"], name: "index_payment_line_items_on_payment_id"
  end

  create_table "payments", force: :cascade do |t|
    t.bigint "user_id"
    t.integer "price"
    t.integer "status"
    t.string "reference"
    t.string "payment_method"
    t.string "response_id"
    t.json "full_response"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "original_payment_id"
    t.bigint "administrator_id"
    t.bigint "discount_code_id"
    t.integer "discount"
    t.json "partials"
    t.integer "billing_address_id"
    t.integer "shipping_address_id"
    t.integer "shipping_method", default: 0
    t.integer "affiliate_id"
    t.integer "affiliate_payment_cents", default: 0, null: false
    t.string "affiliate_payment_currency", default: "USD", null: false
    t.index ["administrator_id"], name: "index_payments_on_administrator_id"
    t.index ["discount_code_id"], name: "index_payments_on_discount_code_id"
    t.index ["original_payment_id"], name: "index_payments_on_original_payment_id"
    t.index ["user_id"], name: "index_payments_on_user_id"
  end

  create_table "performances", force: :cascade do |t|
    t.bigint "event_id"
    t.datetime "start_time"
    t.datetime "end_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_performances_on_deleted_at"
    t.index ["event_id"], name: "index_performances_on_event_id"
  end

  create_table "plans", force: :cascade do |t|
    t.string "remote_id"
    t.string "name"
    t.string "price"
    t.integer "interval"
    t.integer "interval_count"
    t.integer "tickets_allowed"
    t.string "ticket_category"
    t.integer "status"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "shopping_carts", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "address_id"
    t.integer "shipping_method", default: 0
    t.bigint "discount_code_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "affiliate_id"
    t.index ["address_id"], name: "index_shopping_carts_on_address_id"
    t.index ["discount_code_id"], name: "index_shopping_carts_on_discount_code_id"
    t.index ["user_id"], name: "index_shopping_carts_on_user_id"
  end

  create_table "subscriptions", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "plan_id"
    t.date "start_date"
    t.date "end_date"
    t.integer "status"
    t.string "payment_method"
    t.string "remote_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["plan_id"], name: "index_subscriptions_on_plan_id"
    t.index ["user_id"], name: "index_subscriptions_on_user_id"
  end

  create_table "tickets", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "performance_id"
    t.integer "status"
    t.integer "access"
    t.float "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.string "payment_reference"
    t.index ["deleted_at"], name: "index_tickets_on_deleted_at"
    t.index ["performance_id"], name: "index_tickets_on_performance_id"
    t.index ["user_id"], name: "index_tickets_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.string "stripe_id"
    t.integer "role"
    t.string "authy_id"
    t.index ["deleted_at"], name: "index_users_on_deleted_at"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "versions", force: :cascade do |t|
    t.string "item_type", null: false
    t.bigint "item_id", null: false
    t.string "event", null: false
    t.string "whodunnit"
    t.text "object"
    t.datetime "created_at"
    t.text "object_changes"
    t.index ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id"
  end

  add_foreign_key "payment_line_items", "payments"
  add_foreign_key "payments", "users"
  add_foreign_key "performances", "events"
  add_foreign_key "shopping_carts", "addresses"
  add_foreign_key "shopping_carts", "discount_codes"
  add_foreign_key "shopping_carts", "users"
  add_foreign_key "subscriptions", "plans"
  add_foreign_key "subscriptions", "users"
  add_foreign_key "tickets", "performances"
  add_foreign_key "tickets", "users"
end
