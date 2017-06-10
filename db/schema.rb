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

ActiveRecord::Schema.define(version: 20170610222437) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "approval_images", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "product_id"
    t.string   "image"
    t.integer  "status",     default: 0
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.index ["product_id"], name: "index_approval_images_on_product_id", using: :btree
    t.index ["user_id", "product_id"], name: "index_approval_images_on_user_id_and_product_id", unique: true, using: :btree
    t.index ["user_id"], name: "index_approval_images_on_user_id", using: :btree
  end

  create_table "comments", force: :cascade do |t|
    t.text     "body"
    t.integer  "product_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "author_id"
    t.index ["author_id"], name: "index_comments_on_author_id", using: :btree
    t.index ["product_id"], name: "index_comments_on_product_id", using: :btree
  end

  create_table "pg_search_documents", force: :cascade do |t|
    t.text     "content"
    t.string   "searchable_type"
    t.integer  "searchable_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "products", force: :cascade do |t|
    t.string   "name"
    t.string   "brand"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.integer  "used_users_count",  default: 0, null: false
    t.integer  "using_users_count", default: 0, null: false
    t.index ["used_users_count"], name: "index_products_on_used_users_count", using: :btree
    t.index ["using_users_count"], name: "index_products_on_using_users_count", using: :btree
  end

  create_table "usage_manifests", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "product_id"
    t.integer  "status"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.integer  "approved_image_id"
    t.index ["product_id"], name: "index_usage_manifests_on_product_id", using: :btree
    t.index ["user_id"], name: "index_usage_manifests_on_user_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.string   "first_name"
    t.string   "last_name"
    t.boolean  "admin",                  default: false
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  add_foreign_key "approval_images", "products"
  add_foreign_key "approval_images", "users"
  add_foreign_key "comments", "products"
  add_foreign_key "usage_manifests", "products"
  add_foreign_key "usage_manifests", "users"
end
