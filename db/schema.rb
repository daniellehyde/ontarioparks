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

ActiveRecord::Schema.define(version: 2022_01_31_004801) do

  create_table "adjacent_tos", force: :cascade do |t|
    t.string "name"
    t.string "prov"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "adjacent_tos_campsites", id: false, force: :cascade do |t|
    t.integer "campsite_id", null: false
    t.integer "adjacent_to_id", null: false
    t.index ["adjacent_to_id"], name: "index_adjacent_tos_campsites_on_adjacent_to_id"
    t.index ["campsite_id"], name: "index_adjacent_tos_campsites_on_campsite_id"
  end

  create_table "allowed_equipments", force: :cascade do |t|
    t.string "name"
    t.string "prov"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "allowed_equipments_campsites", id: false, force: :cascade do |t|
    t.integer "campsite_id", null: false
    t.integer "allowed_equipment_id", null: false
    t.index ["allowed_equipment_id"], name: "index_allowed_equipments_campsites_on_allowed_equipment_id"
    t.index ["campsite_id"], name: "index_allowed_equipments_campsites_on_campsite_id"
  end

  create_table "campsites", force: :cascade do |t|
    t.string "name"
    t.string "quality"
    t.string "privacy"
    t.integer "park_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "category"
    t.integer "min_capacity"
    t.integer "max_capacity"
    t.text "allowed_equipment"
    t.string "site_shade"
    t.text "conditions"
    t.text "ground_cover"
    t.string "pad_slope"
    t.string "double_site"
    t.text "adjacent_to"
    t.string "service_type"
    t.index ["park_id"], name: "index_campsites_on_park_id"
  end

  create_table "campsites_conditions", id: false, force: :cascade do |t|
    t.integer "campsite_id", null: false
    t.integer "condition_id", null: false
    t.index ["campsite_id"], name: "index_campsites_conditions_on_campsite_id"
    t.index ["condition_id"], name: "index_campsites_conditions_on_condition_id"
  end

  create_table "campsites_equipment", id: false, force: :cascade do |t|
    t.integer "campsite_id", null: false
    t.integer "equipment_id", null: false
    t.index ["campsite_id"], name: "index_campsites_equipment_on_campsite_id"
    t.index ["equipment_id"], name: "index_campsites_equipment_on_equipment_id"
  end

  create_table "campsites_ground_covers", id: false, force: :cascade do |t|
    t.integer "campsite_id", null: false
    t.integer "ground_cover_id", null: false
    t.index ["campsite_id"], name: "index_campsites_ground_covers_on_campsite_id"
    t.index ["ground_cover_id"], name: "index_campsites_ground_covers_on_ground_cover_id"
  end

  create_table "campsites_obstructions", id: false, force: :cascade do |t|
    t.integer "campsite_id", null: false
    t.integer "obstruction_id", null: false
    t.index ["campsite_id"], name: "index_campsites_obstructions_on_campsite_id"
    t.index ["obstruction_id"], name: "index_campsites_obstructions_on_obstruction_id"
  end

  create_table "campsites_restrictions", id: false, force: :cascade do |t|
    t.integer "campsite_id", null: false
    t.integer "restriction_id", null: false
    t.index ["campsite_id"], name: "index_campsites_restrictions_on_campsite_id"
    t.index ["restriction_id"], name: "index_campsites_restrictions_on_restriction_id"
  end

  create_table "conditions", force: :cascade do |t|
    t.string "name"
    t.string "prov"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "equipment", force: :cascade do |t|
    t.string "name"
    t.string "prov"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "ground_covers", force: :cascade do |t|
    t.string "name"
    t.string "prov"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "obstructions", force: :cascade do |t|
    t.string "name"
    t.string "prov"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "parks", force: :cascade do |t|
    t.string "name"
    t.string "city"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "external_park_id"
    t.string "subregion"
    t.string "region"
    t.string "website"
    t.text "description"
  end

  create_table "restrictions", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "prov"
    t.string "category"
  end

  add_foreign_key "campsites", "parks"
end
