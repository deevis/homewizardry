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

ActiveRecord::Schema[7.0].define(version: 2022_07_16_220240) do
  create_table "door_messages", charset: "utf8mb4", force: :cascade do |t|
    t.string "message"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "room_id", null: false
    t.index ["room_id"], name: "index_door_messages_on_room_id"
  end

  create_table "lights", charset: "utf8mb4", force: :cascade do |t|
    t.string "entity_id"
    t.string "name"
    t.bigint "room_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["room_id"], name: "index_lights_on_room_id"
  end

  create_table "played_messages", charset: "utf8mb4", force: :cascade do |t|
    t.string "message", limit: 1000
    t.string "message_type", limit: 40
    t.bigint "room_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["room_id"], name: "index_played_messages_on_room_id"
  end

  create_table "rooms", charset: "utf8mb4", force: :cascade do |t|
    t.string "name"
    t.string "door_contact_id"
    t.string "speaker_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "cooldown_seconds", default: 5
    t.datetime "cooldown_started", precision: nil
    t.string "quiet_hours"
    t.string "say_services", limit: 4000
    t.integer "door_contact_battery_level"
  end

  create_table "sensors", charset: "utf8mb4", force: :cascade do |t|
    t.string "name"
    t.string "sensor_type", limit: 30
    t.string "entity_id"
    t.string "battery_entity_id"
    t.integer "battery_level"
    t.bigint "room_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "last_seen_date"
    t.index ["room_id"], name: "index_sensors_on_room_id"
  end

  add_foreign_key "lights", "rooms"
  add_foreign_key "played_messages", "rooms"
  add_foreign_key "sensors", "rooms"
end
