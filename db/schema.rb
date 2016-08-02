# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20160802182415) do

  create_table "daily_scores", force: :cascade do |t|
    t.integer  "driver_id",                null: false
    t.integer  "vehicle_id",               null: false
    t.integer  "score"
    t.datetime "driving_date"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.integer  "max_score",    default: 0, null: false
  end

  add_index "daily_scores", ["driver_id"], name: "index_daily_scores_on_driver_id"
  add_index "daily_scores", ["driving_date"], name: "index_daily_scores_on_driving_date"
  add_index "daily_scores", ["vehicle_id"], name: "index_daily_scores_on_vehicle_id"

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer  "priority",   default: 0, null: false
    t.integer  "attempts",   default: 0, null: false
    t.text     "handler",                null: false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority"

  create_table "drivers", force: :cascade do |t|
    t.string   "license_id", null: false
    t.integer  "tenant_id",  null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "drivers", ["tenant_id"], name: "index_drivers_on_tenant_id"

  create_table "tenants", force: :cascade do |t|
    t.string   "name"
    t.string   "city"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text     "email"
  end

  add_index "tenants", ["name"], name: "index_tenants_on_name"

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at",                                        null: false
    t.datetime "updated_at",                                        null: false
    t.string   "password_digest"
    t.string   "remember_digest"
    t.boolean  "admin",             default: false
    t.string   "activation_digest"
    t.boolean  "activated",         default: true
    t.datetime "activated_at",      default: '2016-08-02 17:05:18'
    t.string   "reset_digest"
    t.datetime "reset_sent_at"
    t.integer  "tenant_id"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["tenant_id"], name: "index_users_on_tenant_id"

  create_table "vehicles", force: :cascade do |t|
    t.string   "registration", null: false
    t.integer  "tenant_id",    null: false
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "vehicles", ["tenant_id"], name: "index_vehicles_on_tenant_id"

end
