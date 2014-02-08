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

ActiveRecord::Schema.define(version: 20140208193841) do

  create_table "accounts", force: true do |t|
    t.string   "name"
    t.string   "key"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "deposit_address"
    t.decimal  "deposited",       precision: 30, scale: 15, default: 0.0
  end

  create_table "pending_tips", force: true do |t|
    t.decimal  "amount",     precision: 30, scale: 15, default: 0.0
    t.integer  "to_id"
    t.integer  "from_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "pending_tips", ["from_id"], name: "index_pending_tips_on_from_id", using: :btree
  add_index "pending_tips", ["to_id"], name: "index_pending_tips_on_to_id", using: :btree

  create_table "tips", force: true do |t|
    t.integer "from_id"
    t.integer "to_id"
    t.decimal "amount",  precision: 30, scale: 15, default: 0.0
  end

  add_index "tips", ["from_id"], name: "index_tips_on_from_id", using: :btree
  add_index "tips", ["to_id"], name: "index_tips_on_to_id", using: :btree

  create_table "transactions", force: true do |t|
    t.decimal  "amount",     precision: 30, scale: 15, default: 0.0
    t.integer  "account_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "transactions", ["account_id"], name: "index_transactions_on_account_id", using: :btree

  create_table "withdrawals", force: true do |t|
    t.string   "to"
    t.string   "confirmation"
    t.float    "amount"
    t.integer  "account_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "withdrawals", ["account_id"], name: "index_withdrawals_on_account_id", using: :btree

end
