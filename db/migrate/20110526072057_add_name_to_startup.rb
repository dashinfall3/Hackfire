class AddNameToStartup < ActiveRecord::Migration
  def self.up
    add_column :startups, :name, :string
  end

  def self.down
    remove_column :startups, :name
  end
end
