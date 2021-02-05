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

ActiveRecord::Schema.define(version: 2021_02_04_202619) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "balances", force: :cascade do |t|
    t.integer "holder_id"
    t.string "holder_type"
    t.integer "owner_id"
    t.string "owner_type"
    t.integer "fruit_id"
    t.float "amount", default: 0.0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["fruit_id"], name: "index_balances_on_fruit_id"
    t.index ["holder_id", "holder_type"], name: "index_balances_on_holder_id_and_holder_type"
    t.index ["owner_id", "owner_type"], name: "index_balances_on_owner_id_and_owner_type"
    t.index ["updated_at"], name: "index_balances_on_updated_at"
  end

  create_table "events", force: :cascade do |t|
    t.string "slug"
    t.string "name"
    t.jsonb "data"
    t.integer "caretaker_id"
    t.integer "owner_id"
    t.string "owner_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date "date"
    t.time "time"
    t.index ["caretaker_id"], name: "index_events_on_caretaker_id"
    t.index ["owner_id", "owner_type"], name: "index_events_on_owner_id_and_owner_type"
  end

  create_table "fruits", force: :cascade do |t|
    t.string "name"
    t.integer "owner_id"
    t.string "owner_type"
    t.float "monthly_decay"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "monthly_yield", default: 100
    t.index ["owner_id", "owner_type"], name: "index_fruits_on_owner_id_and_owner_type"
  end

  create_table "membershipcards", force: :cascade do |t|
    t.integer "membership_id"
    t.integer "owner_id"
    t.string "owner_type"
    t.integer "epicenter_id"
    t.string "epicenter_type"
    t.boolean "active", default: true
    t.string "payment_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["epicenter_id", "epicenter_type"], name: "index_membershipcards_on_epicenter_id_and_epicenter_type"
    t.index ["membership_id"], name: "index_membershipcards_on_membership_id"
    t.index ["owner_id", "owner_type"], name: "index_membershipcards_on_owner_id_and_owner_type"
  end

  create_table "memberships", force: :cascade do |t|
    t.integer "owner_id"
    t.string "owner_type"
    t.string "name"
    t.text "description"
    t.integer "fee"
    t.integer "gain"
    t.string "rhythm"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["owner_id", "owner_type"], name: "index_memberships_on_owner_id_and_owner_type"
  end

  create_table "movements", force: :cascade do |t|
    t.integer "mother_id", default: 0
    t.string "slug"
    t.string "name"
    t.jsonb "data"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["slug"], name: "index_movements_on_slug", unique: true
  end

  create_table "transactions", force: :cascade do |t|
    t.integer "giver_id"
    t.string "giver_type"
    t.integer "receiver_id"
    t.string "receiver_type"
    t.integer "fruit_id"
    t.float "amount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["created_at"], name: "index_transactions_on_created_at"
    t.index ["fruit_id"], name: "index_transactions_on_fruit_id"
    t.index ["giver_id", "giver_type"], name: "index_transactions_on_giver_id_and_giver_type"
    t.index ["receiver_id", "receiver_type"], name: "index_transactions_on_receiver_id_and_receiver_type"
  end

  create_table "tribes", force: :cascade do |t|
    t.integer "mother_id", default: 0
    t.string "slug"
    t.string "name"
    t.jsonb "data"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["slug"], name: "index_tribes_on_slug", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "slug"
    t.string "name"
    t.jsonb "data"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "yields", force: :cascade do |t|
    t.integer "fruit_id"
    t.integer "receiver_id"
    t.string "receiver_type"
    t.float "amount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["created_at"], name: "index_yields_on_created_at"
    t.index ["fruit_id"], name: "index_yields_on_fruit_id"
    t.index ["receiver_id", "receiver_type"], name: "index_yields_on_receiver_id_and_receiver_type"
  end

end
