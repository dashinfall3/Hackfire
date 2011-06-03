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

ActiveRecord::Schema.define(:version => 20110603204229) do

  create_table "blog_entries", :force => true do |t|
    t.date     "date"
    t.text     "title"
    t.string   "blog_name"
    t.string   "link"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "author"
    t.integer  "guid"
    t.text     "summary"
  end

  create_table "blog_entry_relationships", :force => true do |t|
    t.integer  "blog_entry_id"
    t.integer  "company_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "blog_entry_relationships", ["blog_entry_id"], :name => "index_blog_entry_relationships_on_blog_entry_id"
  add_index "blog_entry_relationships", ["company_id"], :name => "index_blog_entry_relationships_on_company_id"

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

  create_table "facebook_likes", :force => true do |t|
    t.integer  "company_id"
    t.date     "date"
    t.integer  "likes"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "facebook_likes", ["company_id"], :name => "index_facebook_likes_on_company_id"

  create_table "financial_organizations", :force => true do |t|
    t.string   "name"
    t.integer  "investments_number"
    t.string   "type"
    t.integer  "investments_amount"
    t.integer  "exits"
    t.integer  "exits_amount"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "permalink"
  end

  add_index "financial_organizations", ["name"], :name => "index_financial_organizations_on_name"

  create_table "investments", :force => true do |t|
    t.integer  "amount"
    t.string   "series"
    t.integer  "company_id"
    t.integer  "financial_organization_id"
    t.date     "date"
    t.string   "currency"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "investments", ["company_id"], :name => "index_investments_on_company_id"
  add_index "investments", ["financial_organization_id"], :name => "index_investments_on_financial_organization_id"

  create_table "milestones", :force => true do |t|
    t.integer  "startup_id"
    t.string   "type"
    t.text     "description"
    t.date     "date"
    t.string   "source"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "milestones", ["startup_id"], :name => "index_milestones_on_startup_id"

  create_table "people", :force => true do |t|
    t.string   "name"
    t.boolean  "business"
    t.boolean  "technical"
    t.integer  "score"
    t.integer  "investment_score"
    t.integer  "exit_score"
    t.integer  "experience_score"
    t.text     "notes"
    t.integer  "investments"
    t.string   "investor_type"
    t.integer  "investment_amount"
    t.integer  "investment_exits"
    t.integer  "investment_exits_amount"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "permalink"
  end

  add_index "people", ["name"], :name => "index_people_on_name"

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
    t.integer  "social_search_total_mentions"
  end

  add_index "twitter_tweets", ["company_id"], :name => "index_twitter_tweets_on_company_id"

end
