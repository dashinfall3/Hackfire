class CreateStartups < ActiveRecord::Migration
  def self.up
    create_table :startups do |t|
      t.integer :tweets
      t.integer :facebook_likes
      t.integer :traffic_total
      t.integer :blog_mentions
      t.string :industry
      t.text :description
      t.string :entrepeneur1_id
      t.string :entrepreneur2_id
      t.string :entrepreneur3_id

      t.timestamps
    end
  end

  def self.down
    drop_table :startups
  end
end
