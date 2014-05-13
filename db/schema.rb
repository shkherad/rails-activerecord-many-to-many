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

ActiveRecord::Schema.define(version: 20140513201324) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "courses", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "houses", force: true do |t|
    t.string   "name"
    t.integer  "school_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "houses", ["school_id"], name: "index_houses_on_school_id", using: :btree

  create_table "knowledges", force: true do |t|
    t.integer  "student_id"
    t.integer  "spell_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "knowledges", ["spell_id"], name: "index_knowledges_on_spell_id", using: :btree
  add_index "knowledges", ["student_id"], name: "index_knowledges_on_student_id", using: :btree

  create_table "schedules", force: true do |t|
    t.integer  "student_id"
    t.integer  "course_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "schedules", ["course_id"], name: "index_schedules_on_course_id", using: :btree
  add_index "schedules", ["student_id"], name: "index_schedules_on_student_id", using: :btree

  create_table "schools", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "spells", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "students", force: true do |t|
    t.string   "name"
    t.integer  "house_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "students", ["house_id"], name: "index_students_on_house_id", using: :btree

end
