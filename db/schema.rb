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

ActiveRecord::Schema.define(version: 20200806064916) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accounts", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "username"
    t.text     "bio"
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.index ["email"], name: "index_accounts_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_accounts_on_reset_password_token", unique: true, using: :btree
  end

  create_table "cashiers", force: :cascade do |t|
    t.string   "email"
    t.string   "encrypted_password"
    t.string   "access_token"
    t.integer  "user_id"
    t.datetime "created_at",                                  null: false
    t.datetime "updated_at",                                  null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.boolean  "show_ticket_counters",         default: true
    t.boolean  "show_scanned_ticket_counters", default: true
  end

  create_table "communities", force: :cascade do |t|
    t.integer  "account_id"
    t.string   "name"
    t.string   "url"
    t.text     "rules"
    t.integer  "total_members"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["account_id"], name: "index_communities_on_account_id", using: :btree
  end

  create_table "events", force: :cascade do |t|
    t.string   "title"
    t.datetime "start_at"
    t.datetime "end_at"
    t.integer  "user_id"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.integer  "eko_id"
    t.boolean  "eko_continual"
    t.integer  "eko_synced_at"
    t.boolean  "custom"
    t.boolean  "cleaned"
    t.boolean  "inactive",      default: false
    t.index ["eko_id"], name: "index_events_on_eko_id", using: :btree
  end

  create_table "halls", force: :cascade do |t|
    t.string   "name"
    t.integer  "event_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_halls_on_event_id", using: :btree
  end

  create_table "loco_notifications", force: :cascade do |t|
    t.string   "obj_class"
    t.integer  "obj_id"
    t.string   "event"
    t.string   "data"
    t.string   "recipient_class"
    t.integer  "recipient_id"
    t.string   "recipient_token"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "posts", force: :cascade do |t|
    t.integer  "account_id"
    t.integer  "community_id"
    t.string   "title"
    t.text     "body"
    t.integer  "upvotes",       default: 0
    t.integer  "downvotes",     default: 0
    t.integer  "total_comment", default: 0
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.index ["account_id"], name: "index_posts_on_account_id", using: :btree
    t.index ["community_id"], name: "index_posts_on_community_id", using: :btree
  end

  create_table "ticket_types", force: :cascade do |t|
    t.string   "name"
    t.integer  "event_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name", "event_id"], name: "index_ticket_types_on_name_and_event_id", using: :btree
  end

  create_table "tickets", force: :cascade do |t|
    t.string   "code"
    t.string   "x"
    t.string   "y"
    t.datetime "validated_at"
    t.integer  "provider"
    t.integer  "quantity"
    t.integer  "tseq"
    t.integer  "ticket_type_id"
    t.integer  "hall_id"
    t.integer  "event_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.integer  "user_id"
    t.integer  "eko_id"
    t.integer  "eko_event_id"
    t.boolean  "deleted"
    t.index ["eko_id"], name: "index_tickets_on_eko_id", unique: true, where: "(eko_id IS NOT NULL)", using: :btree
    t.index ["event_id"], name: "index_tickets_on_event_id", using: :btree
    t.index ["provider", "code"], name: "index_tickets_on_provider_and_code", using: :btree
  end

  create_table "tmp_users", force: :cascade do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.string   "name"
    t.integer  "user_id"
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.text     "cashiers_events_view",   default: "all"
    t.index ["confirmation_token"], name: "index_tmp_users_on_confirmation_token", unique: true, using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
    t.string   "eko_user"
    t.string   "eko_pass"
    t.string   "email"
    t.string   "encrypted_password"
    t.text     "cashiers_events_view", default: "all"
    t.index ["eko_user"], name: "index_users_on_eko_user", using: :btree
  end

end
