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

ActiveRecord::Schema.define(version: 20170425115237) do

  create_table "apparats", force: :cascade do |t|
    t.string   "name"
    t.string   "serial_number"
    t.integer  "product_type"
    t.text     "description"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.string   "contact"
    t.string   "ip_address"
    t.integer  "company_id"
    t.index ["company_id"], name: "index_apparats_on_company_id"
    t.index ["ip_address"], name: "index_apparats_on_ip_address"
  end

  create_table "apparats_contacts", force: :cascade do |t|
    t.integer "apparat_id"
    t.integer "contact_id"
    t.index ["apparat_id", "contact_id"], name: "index_apparats_contacts_on_apparat_id_and_contact_id", unique: true
    t.index ["apparat_id"], name: "index_apparats_contacts_on_apparat_id"
    t.index ["contact_id"], name: "index_apparats_contacts_on_contact_id"
  end

  create_table "apparats_permits", force: :cascade do |t|
    t.integer  "role",       default: 0
    t.integer  "user_id"
    t.integer  "apparat_id"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.boolean  "locked",     default: false
    t.index ["apparat_id"], name: "index_apparats_permits_on_apparat_id"
    t.index ["user_id", "apparat_id"], name: "index_apparats_permits_on_user_id_and_apparat_id", unique: true
    t.index ["user_id"], name: "index_apparats_permits_on_user_id"
  end

  create_table "companies", force: :cascade do |t|
    t.string   "name"
    t.string   "phone"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["name"], name: "index_companies_on_name"
  end

  create_table "companies_permits", force: :cascade do |t|
    t.integer "role",       default: 0
    t.integer "user_id"
    t.integer "company_id"
    t.index ["company_id"], name: "index_companies_permits_on_company_id"
    t.index ["user_id", "company_id"], name: "index_companies_permits_on_user_id_and_company_id", unique: true
    t.index ["user_id"], name: "index_companies_permits_on_user_id"
  end

  create_table "contacts", force: :cascade do |t|
    t.string   "name",                       null: false
    t.string   "phone"
    t.string   "skype"
    t.string   "email"
    t.integer  "company_id"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.boolean  "default",    default: false
    t.index ["company_id"], name: "index_contacts_on_company_id"
    t.index ["name"], name: "index_contacts_on_name"
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
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.string   "name"
    t.boolean  "admin",                  default: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
