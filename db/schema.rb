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

ActiveRecord::Schema.define(version: 2019_06_01_071650) do

  create_table "seminar_users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "seminar_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["seminar_id"], name: "index_seminar_users_on_seminar_id"
    t.index ["user_id"], name: "index_seminar_users_on_user_id"
  end

  create_table "seminars", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "title"
    t.datetime "date"
    t.string "address"
    t.integer "max"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "line_id"
    t.boolean "date_is", default: false
    t.string "name"
    t.boolean "name_is", default: false
    t.string "name_kana"
    t.boolean "name_kana_is", default: false
    t.string "email"
    t.boolean "email_is", default: false
    t.string "phone_number"
    t.boolean "phone_number_is", default: false
    t.string "introduction_code"
    t.boolean "introduction_code_is", default: false
    t.text "self"
    t.boolean "self_is", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "seminar_users", "seminars"
  add_foreign_key "seminar_users", "users"
end
