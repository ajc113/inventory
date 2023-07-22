# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2023_07_22_114112) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer "priority", default: 0, null: false
    t.integer "attempts", default: 0, null: false
    t.text "handler", null: false
    t.text "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string "locked_by"
    t.string "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["priority", "run_at"], name: "delayed_jobs_priority"
  end

  create_table "flavors", force: :cascade do |t|
    t.string "name", null: false
    t.boolean "archived", default: false
    t.integer "quantity", default: 0
    t.integer "inventory", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "location_flavors", force: :cascade do |t|
    t.integer "quantity", default: 0
    t.integer "inventory", default: 0
    t.bigint "flavor_id", null: false
    t.bigint "location_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["flavor_id", "location_id"], name: "index_location_flavors_on_flavor_id_and_location_id", unique: true
    t.index ["flavor_id"], name: "index_location_flavors_on_flavor_id"
    t.index ["location_id"], name: "index_location_flavors_on_location_id"
  end

  create_table "locations", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "inventory", default: false
  end

  create_table "productions", force: :cascade do |t|
    t.integer "quantity", null: false
    t.bigint "flavor_id", null: false
    t.bigint "location_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["flavor_id"], name: "index_productions_on_flavor_id"
    t.index ["location_id"], name: "index_productions_on_location_id"
  end

  create_table "roles", force: :cascade do |t|
    t.string "name"
    t.string "resource_type"
    t.bigint "resource_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id"
    t.index ["resource_type", "resource_id"], name: "index_roles_on_resource"
  end

  create_table "sales", force: :cascade do |t|
    t.integer "quantity", null: false
    t.bigint "flavor_id", null: false
    t.bigint "location_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["flavor_id"], name: "index_sales_on_flavor_id"
    t.index ["location_id"], name: "index_sales_on_location_id"
  end

  create_table "system_configurations", force: :cascade do |t|
    t.integer "alerting_quantity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "report_recipients", default: [], array: true
  end

  create_table "transfer_requests", force: :cascade do |t|
    t.integer "quantity", null: false
    t.bigint "flavor_id", null: false
    t.bigint "to_location_id", null: false
    t.bigint "from_location_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["flavor_id"], name: "index_transfer_requests_on_flavor_id"
    t.index ["from_location_id"], name: "index_transfer_requests_on_from_location_id"
    t.index ["to_location_id"], name: "index_transfer_requests_on_to_location_id"
  end

  create_table "transfers", force: :cascade do |t|
    t.integer "quantity", null: false
    t.bigint "flavor_id", null: false
    t.bigint "to_location_id", null: false
    t.bigint "from_location_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["flavor_id"], name: "index_transfers_on_flavor_id"
    t.index ["from_location_id"], name: "index_transfers_on_from_location_id"
    t.index ["to_location_id"], name: "index_transfers_on_to_location_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  create_table "users_roles", id: false, force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "role_id"
    t.index ["role_id"], name: "index_users_roles_on_role_id"
    t.index ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id"
    t.index ["user_id"], name: "index_users_roles_on_user_id"
  end

  add_foreign_key "transfer_requests", "locations", column: "from_location_id"
  add_foreign_key "transfer_requests", "locations", column: "to_location_id"
  add_foreign_key "transfers", "locations", column: "from_location_id"
  add_foreign_key "transfers", "locations", column: "to_location_id"
end
