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

ActiveRecord::Schema.define(version: 20160921153420) do

  create_table "bills", force: :cascade do |t|
    t.string   "event",      limit: 255,                  null: false
    t.decimal  "amount",                   precision: 10, null: false
    t.date     "date",                                    null: false
    t.string   "location",   limit: 255,                  null: false
    t.text     "comment",    limit: 65535
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
  end

  create_table "contributions", force: :cascade do |t|
    t.integer  "bill_id",    limit: 4
    t.integer  "from_user",  limit: 4,                null: false
    t.integer  "to_user",    limit: 4,                null: false
    t.decimal  "pay_amt",              precision: 10, null: false
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "contributions", ["bill_id"], name: "index_contributions_on_bill_id", using: :btree

  create_table "payments", force: :cascade do |t|
    t.integer  "from_user",  limit: 4,                null: false
    t.integer  "to_user",    limit: 4,                null: false
    t.decimal  "paid_amt",             precision: 10, null: false
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  create_table "transactions", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.integer  "bill_id",    limit: 4
    t.decimal  "paid_amt",             precision: 10, null: false
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "transactions", ["bill_id"], name: "index_transactions_on_bill_id", using: :btree
  add_index "transactions", ["user_id"], name: "index_transactions_on_user_id", using: :btree

  create_table "user_accounts", force: :cascade do |t|
    t.integer  "from_user",   limit: 4,                null: false
    t.integer  "to_user",     limit: 4,                null: false
    t.decimal  "previous_cf",           precision: 10, null: false
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "name",       limit: 255, null: false
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

end
