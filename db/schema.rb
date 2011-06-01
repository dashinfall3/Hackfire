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

ActiveRecord::Schema.define(:version => 20110531063533) do

  create_table "blog_entries", :force => true do |t|
    t.date     "date"
    t.text     "title"
    t.string   "blog_name"
    t.string   "link"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "employee_relationships", :force => true do |t|
    t.integer  "employee_id"
    t.integer  "company_id"
    t.integer  "tenure"
    t.string   "position"
    t.boolean  "through_exit"
    t.date     "date_joined"
    t.date     "date_left"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "employee_relationships", ["company_id", "employee_id"], :name => "index_employee_relationships_on_company_id_and_employee_id", :unique => true
  add_index "employee_relationships", ["company_id"], :name => "index_employee_relationships_on_company_id"
  add_index "employee_relationships", ["employee_id"], :name => "index_employee_relationships_on_employee_id"

  create_table "employees", :force => true do |t|
    t.string   "name"
    t.boolean  "business"
    t.boolean  "technical"
    t.integer  "score"
    t.integer  "investment_score"
    t.integer  "exit_score"
    t.integer  "experience_score"
    t.text     "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "permalink"
  end

  add_index "employees", ["name"], :name => "index_employees_on_name"
  add_index "employees", ["permalink"], :name => "index_employees_on_permalink"

  create_table "facebook_likes", :force => true do |t|
    t.integer  "company_id"
    t.date     "date"
    t.integer  "likes"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "facebook_likes", ["company_id"], :name => "index_facebook_likes_on_company_id"

  create_table "startups", :force => true do |t|
    t.integer  "tweets"
    t.integer  "facebook_likes"
    t.integer  "traffic_total"
    t.integer  "blog_mentions"
    t.string   "industry"
    t.text     "description"
    t.string   "entrepeneur1_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.string   "url"
    t.string   "twitter_username"
    t.string   "blog_url"
    t.string   "blog_feed_url"
    t.integer  "employees_number"
    t.integer  "founded_year"
    t.integer  "founded_month"
    t.integer  "founded_day"
  end

  add_index "startups", ["name"], :name => "index_startups_on_name"

  create_table "traffic_points", :force => true do |t|
    t.integer  "company_id"
    t.date     "date"
    t.integer  "unique_views"
    t.integer  "visits"
    t.integer  "pageviews"
    t.integer  "time_on_site"
    t.integer  "visits_person"
    t.integer  "pages_visit"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "traffic_points", ["company_id"], :name => "index_traffic_points_on_company_id"

  create_table "twitter_tweets", :force => true do |t|
    t.integer  "company_id"
    t.date     "date"
    t.integer  "tweets_containing"
    t.integer  "mentions"
    t.integer  "followers"
    t.integer  "startup_tweets"
    t.integer  "retweets"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "twitter_tweets", ["company_id"], :name => "index_twitter_tweets_on_company_id"

end
