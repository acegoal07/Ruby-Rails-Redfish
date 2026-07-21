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

ActiveRecord::Schema[8.1].define(version: 2026_07_21_081633) do
  create_table "cabinets", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "name"
    t.string "notes"
    t.integer "u_size"
    t.datetime "updated_at", null: false
  end

  create_table "histories", force: :cascade do |t|
    t.string "bios_version"
    t.integer "cabinet_id"
    t.integer "core_count"
    t.integer "cpu_count"
    t.string "cpu_model"
    t.datetime "created_at", null: false
    t.json "json"
    t.integer "logical_core_count"
    t.integer "memory_total_gib"
    t.string "notes"
    t.integer "server_id"
    t.integer "slot"
    t.string "system_model"
    t.string "system_name"
    t.string "system_uuid"
    t.string "u_position"
    t.datetime "updated_at", null: false
  end

  create_table "servers", force: :cascade do |t|
    t.string "bios_version"
    t.integer "cabinet_id"
    t.integer "core_count"
    t.integer "cpu_count"
    t.string "cpu_model"
    t.datetime "created_at", null: false
    t.json "json"
    t.integer "logical_core_count"
    t.integer "memory_total_gib"
    t.string "notes"
    t.integer "slot"
    t.string "system_model"
    t.string "system_name"
    t.string "system_uuid"
    t.string "u_position"
    t.datetime "updated_at", null: false
  end

  add_foreign_key "histories", "servers"
  add_foreign_key "histories", "servers"
end
