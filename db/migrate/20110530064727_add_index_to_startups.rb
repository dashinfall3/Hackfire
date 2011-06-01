class AddIndexToStartups < ActiveRecord::Migration
  def self.up
  add_index :startups, :name
  end

  def self.down
  end
end
