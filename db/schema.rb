# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2023_01_31_095000) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "coupons", id: false, force: :cascade do |t|
    t.string "uniqid", null: false
    t.string "code"
    t.decimal "discount"
    t.integer "used"
    t.datetime "expire_at"
    t.integer "created_at"
    t.integer "updated_at"
    t.integer "max_uses"
    t.index ["uniqid"], name: "index_coupons_on_uniqid", unique: true
  end

  create_table "events", force: :cascade do |t|
    t.json "payload"
    t.string "source"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "feedbacks", id: false, force: :cascade do |t|
    t.string "uniqid", null: false
    t.integer "score"
    t.text "message"
    t.integer "created_at"
    t.integer "updated_at"
    t.string "invoice_uniqid"
    t.string "product_uniqid"
    t.index ["uniqid"], name: "index_feedbacks_on_uniqid", unique: true
  end

  create_table "orders", id: false, force: :cascade do |t|
    t.string "uniqid", null: false
    t.string "order_type"
    t.decimal "total"
    t.decimal "crypto_exchange_rate"
    t.string "customer_email"
    t.string "gateway"
    t.decimal "crypto_amount"
    t.decimal "crypto_received"
    t.string "country"
    t.decimal "discount"
    t.integer "created_at"
    t.integer "updated_at"
    t.string "coupon_uniqid"
    t.index ["uniqid"], name: "index_orders_on_uniqid", unique: true
  end

  create_table "products", id: false, force: :cascade do |t|
    t.string "uniqid", null: false
    t.string "title"
    t.decimal "price"
    t.integer "warranty"
    t.json "feedback"
    t.integer "sold_count"
    t.decimal "average_score"
    t.index ["uniqid"], name: "index_products_on_uniqid", unique: true
  end

  create_table "users", force: :cascade do |t|
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
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
