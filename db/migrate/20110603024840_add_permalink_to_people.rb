class AddPermalinkToPeople < ActiveRecord::Migration
  def self.up
  	add_column :people, :permalink, :string
  end

  def self.down
  	remove_column :people, :permalink
  end
end
