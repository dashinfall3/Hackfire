class CreateTwitterTweets < ActiveRecord::Migration
  def self.up
    create_table :twitter_tweets do |t|
      t.integer :company_id
      t.date :date
      t.integer :tweets_containing
      t.integer :mentions
      t.integer :followers
      t.integer :startup_tweets
      t.integer :retweets

      t.timestamps
    end
    add_index :twitter_tweets, :company_id
  end

  def self.down
    drop_table :twitter_tweets
  end
end
