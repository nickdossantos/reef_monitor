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

ActiveRecord::Schema.define(version: 20190212201447) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "devices", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.integer "user_id"
    t.integer "tank_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "hash_id"
    t.integer "pin_number"
    t.index ["hash_id"], name: "index_devices_on_hash_id", unique: true
  end

  create_table "readings", force: :cascade do |t|
    t.integer "sensor_id"
    t.float "value"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "tank_id"
    t.datetime "date"
    t.jsonb "data", default: {}
    t.index ["date"], name: "index_readings_on_date", unique: true
  end

  create_table "reports", force: :cascade do |t|
    t.integer "report_type"
    t.jsonb "report_data", default: {}
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "report_date"
  end

  create_table "sensors", force: :cascade do |t|
    t.string "name"
    t.float "goal_value"
    t.integer "tank_id"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "high_value"
    t.float "low_value"
    t.string "hash_id"
    t.index ["hash_id"], name: "index_sensors_on_hash_id", unique: true
  end

  create_table "tanks", force: :cascade do |t|
    t.integer "user_id"
    t.string "name"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "temp_sensor_id"
    t.integer "temp_sensor_pin"
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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
    t.string "first_name"
    t.string "last_name"
    t.string "sms_number"
    t.string "time_zone"
    t.string "hash_id"
    t.string "token"
    t.string "api_endpoint"
    t.integer "email_notification_frequency", default: 0
    t.integer "sms_notification_frequency", default: 0
    t.integer "email_notification_hour", default: 0
    t.integer "sms_notification_hour", default: 0
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["hash_id"], name: "index_users_on_hash_id", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["token"], name: "index_users_on_token", unique: true
  end

end
