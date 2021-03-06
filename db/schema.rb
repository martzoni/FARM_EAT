# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_08_23_075237) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "distances", force: :cascade do |t|
    t.bigint "farm_a_id"
    t.bigint "farm_b_id"
    t.float "km"
    t.float "minutes"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["farm_a_id"], name: "index_distances_on_farm_a_id"
    t.index ["farm_b_id"], name: "index_distances_on_farm_b_id"
  end

  create_table "farms", force: :cascade do |t|
    t.string "name"
    t.string "address"
    t.text "content"
    t.string "open_hours"
    t.string "phone"
    t.string "email"
    t.string "web_site"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "user_id", null: false
    t.float "latitude"
    t.float "longitude"
    t.index ["user_id"], name: "index_farms_on_user_id"
  end

  create_table "groceries", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "start_address"
    t.string "end_address"
    t.index ["user_id"], name: "index_groceries_on_user_id"
  end

  create_table "grocery_products", force: :cascade do |t|
    t.bigint "product_id", null: false
    t.bigint "grocery_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["grocery_id"], name: "index_grocery_products_on_grocery_id"
    t.index ["product_id"], name: "index_grocery_products_on_product_id"
  end

  create_table "products", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "category"
  end

  create_table "stocks", force: :cascade do |t|
    t.bigint "farm_id", null: false
    t.boolean "in_stock_today"
    t.boolean "season"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "product_id"
    t.index ["farm_id"], name: "index_stocks_on_farm_id"
    t.index ["product_id"], name: "index_stocks_on_product_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "address"
    t.string "name"
    t.boolean "is_farmer"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "distances", "farms", column: "farm_a_id"
  add_foreign_key "distances", "farms", column: "farm_b_id"
  add_foreign_key "farms", "users"
  add_foreign_key "groceries", "users"
  add_foreign_key "grocery_products", "groceries"
  add_foreign_key "grocery_products", "products"
  add_foreign_key "stocks", "farms"
  add_foreign_key "stocks", "products"
end
