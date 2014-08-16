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

ActiveRecord::Schema.define(version: 20140816155459) do

  create_table "collaborations", force: true do |t|
    t.integer "project_id"
    t.integer "user_id"
  end

  add_index "collaborations", ["project_id", "user_id"], name: "index_collaborations_on_project_id_and_user_id"
  add_index "collaborations", ["user_id", "project_id"], name: "index_collaborations_on_user_id_and_project_id"

  create_table "comments", force: true do |t|
    t.integer  "version_id"
    t.string   "text"
    t.integer  "start_time"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "important",  default: false
    t.boolean  "addressed",  default: false
    t.integer  "user_id"
  end

  create_table "group_users", force: true do |t|
    t.integer "group_id"
    t.integer "user_id"
    t.boolean "admin",    default: false
  end

  add_index "group_users", ["group_id"], name: "index_group_users_on_group_id"
  add_index "group_users", ["user_id"], name: "index_group_users_on_user_id"

  create_table "groups", force: true do |t|
    t.string "title"
    t.string "slug"
  end

  add_index "groups", ["slug"], name: "index_groups_on_slug"

  create_table "projects", force: true do |t|
    t.string   "title"
    t.string   "description"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "aasm_state"
    t.string   "slug"
    t.integer  "group_id"
  end

  add_index "projects", ["group_id"], name: "index_projects_on_group_id"
  add_index "projects", ["slug"], name: "index_projects_on_slug", unique: true

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.string   "username"
    t.string   "slug"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  add_index "users", ["slug"], name: "index_users_on_slug", unique: true

  create_table "versions", force: true do |t|
    t.string   "title"
    t.string   "description"
    t.integer  "project_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "approved",          default: false
    t.string   "file_file_name"
    t.string   "file_content_type"
    t.integer  "file_file_size"
    t.datetime "file_updated_at"
  end

end
