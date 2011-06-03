class AddAuthorToBlogEntries < ActiveRecord::Migration
  def self.up
  	add_column :blog_entries, :author, :string
  	add_column :blog_entries, :guid, :integer
  end

  def self.down
    remove_column :blog_entries, :author
  	remove_column :blog_entries, :guid
  end
end
