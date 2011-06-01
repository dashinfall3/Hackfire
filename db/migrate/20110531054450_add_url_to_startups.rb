class AddUrlToStartups < ActiveRecord::Migration
  def self.up
  	add_column :startups, :url, :string
  	add_column :startups, :twitter_username, :string
  	add_column :startups, :blog_url, :string
  	add_column :startups, :blog_feed_url, :string
  	add_column :startups, :employees_number, :integer
  	add_column :startups, :founded_year, :integer
  	add_column :startups, :founded_month, :integer
  	add_column :startups, :founded_day, :integer
  	remove_column :startups, :entrepreneur1_id
  	remove_column :startups, :entrepreneur2_id
  	remove_column :startups, :entrepreneur3_id
  end

  def self.down
  	remove_column :startups, :url
  	remove_column :startups, :twitter_username
  	remove_column :startups, :blog_url
  	remove_column :startups, :blog_feed_url
  	remove_column :startups, :employees_number
  	remove_column :startups, :founded_year
  	remove_column :startups, :founded_month
  	remove_column :startups, :founded_day
  end
end
