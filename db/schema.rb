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

ActiveRecord::Schema.define(version: 0) do

  create_table "email_verifies", force: :cascade do |t|
    t.string   "email",     limit: 32, null: false
    t.string   "token",     limit: 64, null: false
    t.datetime "expire_at",            null: false
  end

  create_table "invite_codes", force: :cascade do |t|
    t.string   "code",       limit: 128,                 null: false
    t.integer  "user_id",    limit: 4,                   null: false
    t.boolean  "used",                   default: false, null: false
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
  end

  add_index "invite_codes", ["user_id"], name: "user_id", using: :btree

  create_table "nodes", force: :cascade do |t|
    t.string  "name",          limit: 128,                 null: false
    t.integer "cata",          limit: 4,                   null: false
    t.string  "server",        limit: 128,                 null: false
    t.string  "method",        limit: 64,                  null: false
    t.boolean "custom_method",             default: false, null: false
    t.float   "traffic_rate",  limit: 24,  default: 1.0,   null: false
    t.string  "info",          limit: 128,                 null: false
    t.string  "status",        limit: 128, default: "0",   null: false
    t.integer "offset",        limit: 4,   default: 0,     null: false
  end

  create_table "password_resets", force: :cascade do |t|
    t.string   "email",     limit: 32,  null: false
    t.string   "token",     limit: 128, null: false
    t.datetime "expire_at",             null: false
  end

  create_table "site_configs", force: :cascade do |t|
    t.string   "key",        limit: 128,   null: false
    t.text     "value",      limit: 65535, null: false
    t.datetime "updated_at",               null: false
    t.datetime "created_at",               null: false
  end

  create_table "user", force: :cascade do |t|
    t.string   "user_name",           limit: 128,                       null: false
    t.string   "email",               limit: 32,                        null: false
    t.string   "pass",                limit: 64,                        null: false
    t.string   "passwd",              limit: 64,  default: "",          null: false
    t.integer  "t",                   limit: 4,   default: 0,           null: false
    t.integer  "u",                   limit: 8,   default: 0,           null: false
    t.integer  "d",                   limit: 8,   default: 0,           null: false
    t.integer  "transfer_enable",     limit: 8,                         null: false
    t.integer  "port",                limit: 4,                         null: false
    t.integer  "switch",              limit: 1,   default: 1,           null: false
    t.integer  "enable",              limit: 1,   default: 1,           null: false
    t.integer  "type",                limit: 1,   default: 1,           null: false
    t.integer  "last_get_gift_time",  limit: 4,   default: 0,           null: false
    t.integer  "last_check_in_time",  limit: 4,   default: 0,           null: false
    t.integer  "last_rest_pass_time", limit: 4,   default: 0,           null: false
    t.integer  "invite_num",          limit: 4,   default: 0,           null: false
    t.integer  "is_admin",            limit: 4,   default: 0,           null: false
    t.integer  "ref_by",              limit: 4,   default: 0,           null: false
    t.integer  "expire_time",         limit: 4,   default: 0,           null: false
    t.string   "method",              limit: 64,  default: "rc4-md5",   null: false
    t.integer  "is_email_verify",     limit: 1,   default: 0,           null: false
    t.string   "avatar",              limit: 256
    t.string   "reg_ip",              limit: 128, default: "127.0.0.1", null: false
    t.string   "avatar_file_name",    limit: 256
    t.integer  "avatar_file_size",    limit: 4
    t.string   "avatar_content_type", limit: 50,  default: "image/jpg"
    t.datetime "created_at",                                            null: false
    t.datetime "updated_at",                                            null: false
  end

  add_index "user", ["email"], name: "email", unique: true, using: :btree
  add_index "user", ["port"], name: "ux_port", unique: true, using: :btree

  create_table "user_comments", force: :cascade do |t|
    t.integer  "user_id",    limit: 4,                null: false
    t.string   "content",    limit: 256, default: "", null: false
    t.string   "avatar",     limit: 256, default: "", null: false
    t.string   "user_name",  limit: 50,  default: "", null: false
    t.datetime "updated_at",                          null: false
    t.datetime "created_at",                          null: false
  end

  create_table "user_tokens", force: :cascade do |t|
    t.string   "token",      limit: 256, null: false
    t.integer  "user_id",    limit: 4,   null: false
    t.datetime "expired_at",             null: false
  end

  create_table "user_traffic_logs", force: :cascade do |t|
    t.integer  "user_id", limit: 4,  null: false
    t.integer  "u",       limit: 8,  null: false
    t.integer  "d",       limit: 8,  null: false
    t.integer  "traffic", limit: 8,  null: false
    t.integer  "node_id", limit: 4,  null: false
    t.float    "rate",    limit: 24, null: false
    t.datetime "log_at",             null: false
  end

end
