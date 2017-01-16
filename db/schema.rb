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

  create_table "customers", unsigned: true, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string  "name",        limit: 50,  default: "",    null: false
    t.string  "email",       limit: 128, default: "",    null: false
    t.string  "order_date",  limit: 20,  default: "",    null: false
    t.integer "offer_month",             default: 1,     null: false
    t.string  "password",    limit: 128, default: "",    null: false
    t.integer "port",                    default: 0,     null: false
    t.boolean "effect",                  default: false, null: false
    t.string  "pass",        limit: 50,  default: "",    null: false
  end

  create_table "email_verifies", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "email",     limit: 32, null: false
    t.string   "token",     limit: 64, null: false
    t.datetime "expire_at",            null: false
  end

  create_table "invite_codes", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "code",       limit: 128,                 null: false
    t.integer  "user_id",                                null: false
    t.boolean  "used",                   default: false, null: false
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.index ["user_id"], name: "user_id", using: :btree
  end

  create_table "node_info_logs", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "node_id",             null: false
    t.float   "uptime",   limit: 24, null: false
    t.string  "load",     limit: 32, null: false
    t.integer "log_time",            null: false
  end

  create_table "node_online_logs", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "node_id",     null: false
    t.integer "online_user", null: false
    t.integer "log_time",    null: false
  end

  create_table "nodes", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string  "name",          limit: 128,                 null: false, collation: "utf8mb4_general_ci"
    t.integer "cata",                                      null: false
    t.string  "server",        limit: 128,                 null: false, collation: "utf8mb4_general_ci"
    t.string  "method",        limit: 64,                  null: false, collation: "utf8mb4_general_ci"
    t.boolean "custom_method",             default: false, null: false
    t.float   "traffic_rate",  limit: 24,  default: 1.0,   null: false
    t.string  "info",          limit: 128,                 null: false, collation: "utf8mb4_general_ci"
    t.string  "status",        limit: 128, default: "0",   null: false, collation: "utf8mb4_general_ci"
    t.integer "offset",                    default: 0,     null: false
  end

  create_table "password_resets", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "email",     limit: 32,  null: false, collation: "latin1_swedish_ci"
    t.string   "token",     limit: 128, null: false, collation: "latin1_swedish_ci"
    t.datetime "expire_at",             null: false
  end

  create_table "site_configs", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "key",        limit: 128,   null: false
    t.text     "value",      limit: 65535, null: false
    t.datetime "updated_at",               null: false
    t.datetime "created_at",               null: false
  end

  create_table "user", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "user_name",              limit: 128,                                      null: false, collation: "utf8mb4_general_ci"
    t.string   "email",                  limit: 32,                                       null: false
    t.string   "encrypted_password",                 default: "",                         null: false
    t.string   "passwd",                             default: "",                         null: false
    t.integer  "t",                                  default: 0,                          null: false
    t.bigint   "u",                                  default: 0,                          null: false
    t.bigint   "d",                                  default: 0,                          null: false
    t.bigint   "transfer_enable",                    default: 5373952000,                 null: false
    t.integer  "port",                                                                    null: false
    t.integer  "switch",                 limit: 1,   default: 1,                          null: false
    t.integer  "enable",                 limit: 1,   default: 1,                          null: false
    t.integer  "type",                   limit: 1,   default: 1,                          null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.integer  "last_get_gift_time",                 default: 0,                          null: false
    t.integer  "last_check_in_time",                 default: 0,                          null: false
    t.integer  "last_rest_pass_time",                default: 0,                          null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 20,  default: "",                         null: false
    t.datetime "remember_created_at"
    t.string   "last_sign_in_ip",        limit: 20,  default: "",                         null: false
    t.integer  "sign_in_count",                      default: 0,                          null: false
    t.datetime "reg_date",                           default:"2016-11-05 08:59:18",       null: false
    t.integer  "invite_num",                         default: 0,                          null: false
    t.boolean  "is_admin",                           default: false,                      null: false
    t.integer  "ref_by",                             default: 0,                          null: false
    t.integer  "expire_time",                        default: 0,                          null: false
    t.string   "method",                 limit: 64,  default: "aes-256-cfb",              null: false
    t.integer  "is_email_verify",        limit: 1,   default: 0,                          null: false
    t.string   "reg_ip",                 limit: 128, default: "127.0.0.1",                null: false
    t.string   "avatar",                 limit: 256
    t.string   "avatar_file_name",       limit: 256
    t.integer  "avatar_file_size"
    t.string   "avatar_content_type",    limit: 50,  default: "image/jpg"
    t.datetime "updated_at",                         default: '2016-11-05 08:59:18',      null: false
    t.datetime "created_at",                         default: '2016-11-05 08:59:18',      null: false
    t.index ["email"], name: "email", unique: true, using: :btree
    t.index ["port"], name: "ux_port", unique: true, using: :btree
  end

  create_table "user_comments", unsigned: true, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id",                             null: false
    t.string   "content",    limit: 256, default: "", null: false
    t.string   "avatar",     limit: 256, default: "", null: false
    t.string   "user_name",  limit: 50,  default: "", null: false
    t.datetime "updated_at",                          null: false
    t.datetime "created_at",                          null: false
  end

  create_table "user_copy", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "user_name",           limit: 128,                                      null: false, collation: "utf8mb4_general_ci"
    t.string   "email",               limit: 32,                                       null: false
    t.string   "pass",                limit: 64,                                       null: false
    t.string   "passwd",              limit: 64,  default: "",                         null: false
    t.integer  "t",                               default: 0,                          null: false
    t.bigint   "u",                               default: 0,                          null: false
    t.bigint   "d",                               default: 0,                          null: false
    t.bigint   "transfer_enable",                                                      null: false
    t.integer  "port",                                                                 null: false
    t.integer  "switch",              limit: 1,   default: 1,                          null: false
    t.integer  "enable",              limit: 1,   default: 1,                          null: false
    t.integer  "type",                limit: 1,   default: 1,                          null: false
    t.integer  "last_get_gift_time",              default: 0,                          null: false
    t.integer  "last_check_in_time",              default: 0,                          null: false
    t.integer  "last_rest_pass_time",             default: 0,                          null: false
    t.datetime "reg_date",                        default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.integer  "invite_num",                      default: 0,                          null: false
    t.integer  "is_admin",                        default: 0,                          null: false
    t.integer  "ref_by",                          default: 0,                          null: false
    t.integer  "expire_time",                     default: 0,                          null: false
    t.string   "method",              limit: 64,  default: "rc4-md5",                  null: false
    t.integer  "is_email_verify",     limit: 1,   default: 0,                          null: false
    t.string   "avatar",              limit: 256
    t.string   "reg_ip",              limit: 128, default: "127.0.0.1",                null: false
    t.string   "avatar_file_name",    limit: 256
    t.integer  "avatar_file_size"
    t.string   "avatar_content_type", limit: 50,  default: "image/jpg"
    t.index ["email"], name: "email", unique: true, using: :btree
    t.index ["port"], name: "ux_port", unique: true, using: :btree
  end

  create_table "user_tokens", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "token",      limit: 256, null: false
    t.integer  "user_id",                null: false
    t.datetime "expired_at",             null: false
  end

  create_table "user_traffic_logs", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id",            null: false
    t.bigint   "u",                  null: false
    t.bigint   "d",                  null: false
    t.bigint   "traffic",            null: false
    t.integer  "node_id",            null: false
    t.float    "rate",    limit: 24, null: false
    t.datetime "log_at",             null: false
  end

end
