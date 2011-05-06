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

ActiveRecord::Schema.define(:version => 20110304149999) do

  create_table "countries", :force => true do |t|
    t.string   "name"
    t.string   "countrycode"
    t.boolean  "visited"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "countries_trips", :id => false, :force => true do |t|
    t.integer "country_id"
    t.integer "trip_id"
  end

  create_table "currencies", :force => true do |t|
    t.string   "name"
    t.string   "currencycode"
    t.boolean  "collected"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "monetizations", :force => true do |t|
    t.integer "country_id"
    t.integer "currency_id"
    t.integer "visited_numbers"
    t.boolean "visited"
  end

  create_table "trips", :force => true do |t|
    t.string   "description"
    t.datetime "date"
    t.string   "status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
