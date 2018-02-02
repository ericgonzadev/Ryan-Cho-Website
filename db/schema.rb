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

ActiveRecord::Schema.define(version: 20180202221016) do

  create_table "information", force: :cascade do |t|
    t.string   "name"
    t.string   "headline"
    t.string   "headline_description"
    t.text     "about_me"
    t.text     "contact_description"
    t.string   "quote"
    t.string   "facebook"
    t.string   "twitter"
    t.string   "instagram"
    t.string   "linkedin"
    t.string   "vimeo"
    t.string   "youtube"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.string   "email"
    t.string   "phone"
    t.string   "about_image"
    t.string   "resume"
  end

  create_table "messages", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "subject"
    t.text     "message"
    t.string   "captcha"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "projects", force: :cascade do |t|
    t.string   "title"
    t.string   "description"
    t.string   "link"
    t.string   "video_source"
    t.string   "work_type"
    t.string   "thumbnail"
    t.integer  "order_listed"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.string   "video_id"
  end

end
