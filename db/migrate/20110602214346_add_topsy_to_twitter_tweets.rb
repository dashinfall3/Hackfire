class AddTopsyToTwitterTweets < ActiveRecord::Migration
  def self.up
  	add_column :twitter_tweets, :social_search_total_mentions, :integer
  end

  def self.down
  	add_column :twitter_tweets, :social_search_total_mentions
  end
end
