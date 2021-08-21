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

ActiveRecord::Schema.define(version: 2021_08_21_211934) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "campsites", force: :cascade do |t|
    t.string "name"
    t.string "quality"
    t.string "privacy"
    t.bigint "park_id", null: false
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

  create_table "parks", force: :cascade do |t|
    t.string "name"
    t.string "city"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "external_park_id"
    t.string "subregion"
    t.string "region"
    t.string "website"
  end

  add_foreign_key "campsites", "parks"
end
