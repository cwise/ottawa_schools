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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20101204115338) do

  create_table "boards", :force => true do |t|
    t.string   "code",       :null => false
    t.string   "name",       :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "grades", :force => true do |t|
    t.integer  "index",       :null => false
    t.string   "abbrev",      :null => false
    t.string   "description", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "schools", :force => true do |t|
    t.integer  "board_id",                          :null => false
    t.string   "name",                              :null => false
    t.string   "street_address",                    :null => false
    t.string   "city",                              :null => false
    t.string   "postal_code",                       :null => false
    t.string   "phone"
    t.string   "fax"
    t.integer  "start_grade_id"
    t.integer  "end_grade_id"
    t.time     "start_time"
    t.boolean  "semestered",     :default => false
    t.boolean  "adaptive",       :default => false
    t.time     "end_time"
    t.string   "principal"
    t.string   "vice_principal"
    t.string   "url"
    t.float    "latitude"
    t.float    "longitude"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
