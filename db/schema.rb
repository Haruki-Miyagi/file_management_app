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

ActiveRecord::Schema.define(version: 2019_05_10_033121) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "documents", force: :cascade do |t|
    t.string "file_name", null: false
    t.string "uploaded_file", null: false
    t.text "description"
    t.bigint "user_id"
    t.bigint "room_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["description"], name: "index_documents_on_description"
    t.index ["file_name"], name: "index_documents_on_file_name"
    t.index ["room_id"], name: "index_documents_on_room_id"
    t.index ["user_id"], name: "index_documents_on_user_id"
  end

  create_table "folders", force: :cascade do |t|
    t.string "name", null: false
    t.text "description"
    t.string "ancestry"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ancestry"], name: "index_folders_on_ancestry"
    t.index ["description"], name: "index_folders_on_description"
    t.index ["name"], name: "index_folders_on_name"
    t.index ["user_id"], name: "index_folders_on_user_id"
  end

  create_table "messages", force: :cascade do |t|
    t.text "content", null: false
    t.bigint "user_id"
    t.bigint "room_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["room_id"], name: "index_messages_on_room_id"
    t.index ["user_id"], name: "index_messages_on_user_id"
  end

  create_table "rooms", force: :cascade do |t|
    t.string "name", null: false
    t.text "description"
    t.bigint "folder_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["description"], name: "index_rooms_on_description"
    t.index ["folder_id"], name: "index_rooms_on_folder_id"
    t.index ["name"], name: "index_rooms_on_name"
    t.index ["user_id"], name: "index_rooms_on_user_id"
  end

  create_table "user_controll_rooms", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "room_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["room_id"], name: "index_user_controll_rooms_on_room_id"
    t.index ["user_id", "room_id"], name: "index_user_controll_rooms_on_user_id_and_room_id", unique: true
    t.index ["user_id"], name: "index_user_controll_rooms_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "admin", default: false, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "documents", "rooms"
  add_foreign_key "documents", "users"
  add_foreign_key "folders", "users"
  add_foreign_key "messages", "rooms"
  add_foreign_key "messages", "users"
  add_foreign_key "rooms", "folders"
  add_foreign_key "rooms", "users"
  add_foreign_key "user_controll_rooms", "rooms"
  add_foreign_key "user_controll_rooms", "users"
end
