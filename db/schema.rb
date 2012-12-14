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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20121205084436) do

  create_table "audits", :force => true do |t|
    t.integer  "auditable_id"
    t.string   "auditable_type"
    t.integer  "associated_id"
    t.string   "associated_type"
    t.integer  "user_id"
    t.string   "user_type"
    t.string   "username"
    t.string   "action"
    t.text     "audited_changes"
    t.integer  "version",         :default => 0
    t.string   "comment"
    t.string   "remote_address"
    t.datetime "created_at"
  end

  add_index "audits", ["associated_id", "associated_type"], :name => "associated_index"
  add_index "audits", ["auditable_id", "auditable_type"], :name => "auditable_index"
  add_index "audits", ["created_at"], :name => "index_audits_on_created_at"
  add_index "audits", ["user_id", "user_type"], :name => "user_index"

  create_table "events", :force => true do |t|
    t.string   "name",             :limit => 40,   :null => false
    t.string   "start_time",       :limit => 16,   :null => false
    t.string   "end_time",         :limit => 16,   :null => false
    t.string   "province",         :limit => 20,   :null => false
    t.string   "city",             :limit => 20,   :null => false
    t.string   "address",          :limit => 80,   :null => false
    t.string   "category",         :limit => 20,   :null => false
    t.text     "detail",                           :null => false
    t.string   "banner",           :limit => 150,  :null => false
    t.string   "telephone",        :limit => 12
    t.integer  "host_id",          :limit => 8,    :null => false
    t.integer  "size"
    t.string   "seller_name",      :limit => 20,   :null => false
    t.string   "seller_telephone", :limit => 12,   :null => false
    t.string   "seller_email",     :limit => 40
    t.string   "site_url",         :limit => 40
    t.string   "short_url",        :limit => 40
    t.string   "notice",           :limit => 1024
    t.boolean  "is_public"
    t.string   "status",           :limit => 20
    t.integer  "user_id",          :limit => 8,    :null => false
    t.datetime "created_at",                       :null => false
  end

  create_table "field_templates", :id => false, :force => true do |t|
    t.string  "name",        :limit => 40, :null => false
    t.string  "type",        :limit => 1,  :null => false
    t.string  "subtype",     :limit => 1
    t.string  "options",     :limit => 40
    t.boolean "is_required",               :null => false
  end

  create_table "fields", :force => true do |t|
    t.string  "name",           :limit => 40,  :null => false
    t.string  "maintype",       :limit => 10,  :null => false
    t.string  "subtype",        :limit => 10
    t.string  "options",        :limit => 400
    t.boolean "is_required",                   :null => false
    t.boolean "is_common",                     :null => false
    t.string  "fieldable_type", :limit => 10,  :null => false
    t.integer "fieldable_id",   :limit => 8
    t.integer "index",                         :null => false
    t.boolean "multiple"
  end

  create_table "host_certifications", :force => true do |t|
    t.string  "type",              :limit => 10, :null => false
    t.string  "telephone",         :limit => 12, :null => false
    t.string  "email",             :limit => 40, :null => false
    t.string  "offical_name",      :limit => 60, :null => false
    t.string  "identity_no",       :limit => 60, :null => false
    t.string  "identity_no_image", :limit => 30, :null => false
    t.string  "account_bank",      :limit => 50, :null => false
    t.string  "account_no",        :limit => 80, :null => false
    t.string  "card_image",        :limit => 30, :null => false
    t.integer "version"
    t.string  "audit_status",      :limit => 20, :null => false
  end

  create_table "hosts", :force => true do |t|
    t.string  "name",      :limit => 40,   :null => false
    t.string  "detail",    :limit => 1024, :null => false
    t.string  "telephone", :limit => 12,   :null => false
    t.string  "website",   :limit => 40
    t.string  "weibo",     :limit => 40
    t.string  "email",     :limit => 40
    t.string  "msn",       :limit => 40
    t.string  "qq",        :limit => 20
    t.string  "province",  :limit => 20,   :null => false
    t.string  "city",      :limit => 20,   :null => false
    t.string  "address",   :limit => 80,   :null => false
    t.string  "status",    :limit => 1
    t.integer "user_id",   :limit => 8,    :null => false
  end

  create_table "members", :force => true do |t|
    t.string   "loginname",    :limit => 40,  :null => false
    t.string   "realname",     :limit => 20
    t.string   "password",     :limit => 128, :null => false
    t.string   "mobile_phone", :limit => 12
    t.string   "email",        :limit => 40
    t.string   "msn",          :limit => 40
    t.string   "qq",           :limit => 20
    t.string   "website",      :limit => 40
    t.string   "weibo",        :limit => 40
    t.string   "status",       :limit => 1
    t.datetime "create_time"
  end

  create_table "order_items", :force => true do |t|
    t.integer "order_id",       :limit => 8,                                :null => false
    t.integer "ticket_type_id", :limit => 8,                                :null => false
    t.integer "quantity",                                                   :null => false
    t.decimal "price",                       :precision => 10, :scale => 2, :null => false
    t.text    "tickets"
  end

  create_table "orders", :force => true do |t|
    t.string  "order_no",     :limit => 40,                                                  :null => false
    t.string  "realname",     :limit => 40,                                                  :null => false
    t.string  "mobile_phone", :limit => 12,                                                  :null => false
    t.string  "email",        :limit => 40,                                                  :null => false
    t.integer "user_id"
    t.decimal "total_fee",                    :precision => 10, :scale => 2
    t.string  "subject",      :limit => 256,                                 :default => "", :null => false
    t.string  "body",         :limit => 1000,                                :default => "", :null => false
    t.string  "show_url",     :limit => 400,                                 :default => "", :null => false
    t.string  "status",       :limit => 20,                                                  :null => false
  end

  create_table "posts", :force => true do |t|
    t.string   "name"
    t.string   "title"
    t.text     "content"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "questionnaires", :force => true do |t|
  end

  create_table "registration", :force => true do |t|
    t.integer "event_id",    :limit => 8,  :null => false
    t.integer "field_id",    :limit => 8,  :null => false
    t.string  "field_value", :limit => 80, :null => false
    t.text    "adminssions"
  end

  create_table "rich_rich_files", :force => true do |t|
    t.datetime "created_at",                                 :null => false
    t.datetime "updated_at",                                 :null => false
    t.string   "rich_file_file_name"
    t.string   "rich_file_content_type"
    t.integer  "rich_file_file_size"
    t.datetime "rich_file_updated_at"
    t.string   "owner_type"
    t.integer  "owner_id"
    t.text     "uri_cache"
    t.string   "simplified_type",        :default => "file"
  end

  create_table "tags", :id => false, :force => true do |t|
    t.string  "name",          :limit => 40, :null => false
    t.string  "taggable_type", :limit => 10, :null => false
    t.integer "taggable_id",   :limit => 8,  :null => false
  end

  create_table "tickets", :force => true do |t|
    t.string  "ticket_no",     :limit => 40,                          :null => false
    t.integer "ticketware_id", :limit => 8,                           :null => false
    t.string  "status",        :limit => 20, :default => "available", :null => false
  end

  create_table "tickets", :force => true do |t|
    t.string  "name",            :limit => 40,                                                   :null => false
    t.string  "package",         :limit => 20,                                                   :null => false
    t.string  "type",            :limit => 20,                                                   :null => false
    t.decimal "online_price",                    :precision => 10, :scale => 2, :default => 0.0, :null => false
    t.decimal "offline_price",                   :precision => 10, :scale => 2
    t.integer "capacity",                                                                        :null => false
    t.integer "available",                                                                       :null => false
    t.integer "reserved",                                                       :default => 0,   :null => false
    t.string  "notice",          :limit => 1024
    t.string  "sale_start_time", :limit => 16
    t.string  "sale_end_time",   :limit => 16
    t.integer "order_min"
    t.integer "order_max"
    t.integer "event_id",        :limit => 8,                                                    :null => false
    t.string  "status",          :limit => 20,                                                   :null => false
  end

  create_table "transactions", :force => true do |t|
  end

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.text     "roles"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
