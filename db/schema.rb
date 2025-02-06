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

ActiveRecord::Schema[8.0].define(version: 2025_02_06_191933) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"
  enable_extension "pg_trgm"
  enable_extension "unaccent"

  create_table "examples", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "products", force: :cascade do |t|
    t.string "name"
    t.string "kcal"
    t.string "protein"
    t.string "carbs"
    t.string "fat"
    t.string "fiber"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "source"
    t.string "brand"
    t.text "unaccented_name"
    t.string "unaccented_brand"
    t.index "to_tsvector('simple'::regconfig, unaccented_name)", name: "products_unaccented_name_gin", using: :gin
    t.index ["unaccented_brand"], name: "index_products_on_unaccented_brand"
    t.index ["unaccented_name"], name: "products_unaccented_name_trgm", opclass: :gin_trgm_ops, using: :gin
  end
end
