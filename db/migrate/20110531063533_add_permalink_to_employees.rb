class AddPermalinkToEmployees < ActiveRecord::Migration
  def self.up
  	  add_column :employees, :permalink, :string
  	  remove_column :startups, :entrepreneur1_id
  	  add_index :employees, :permalink
  end

  def self.down
  	  remove_column :employees, :permalink, :string
  end
end
