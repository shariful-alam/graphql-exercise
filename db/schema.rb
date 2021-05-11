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

ActiveRecord::Schema.define(version: 20210511171935) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "properties", force: :cascade do |t|
    t.string   "name"
    t.string   "website_url"
    t.jsonb    "hours",                   default: {}, null: false
    t.string   "address"
    t.string   "amenities_url"
    t.string   "floor_plan_url"
    t.string   "gallery_url"
    t.string   "contact_us_url"
    t.string   "neighborhood_url"
    t.string   "features_url"
    t.string   "facebook_url"
    t.string   "instagram_url"
    t.string   "text_color"
    t.string   "button_background_color"
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
  end

end
