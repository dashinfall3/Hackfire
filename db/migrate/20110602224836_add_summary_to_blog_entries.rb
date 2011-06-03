class AddSummaryToBlogEntries < ActiveRecord::Migration
  def self.up
  	  add_column :blog_entries, :summary, :text
  	  remove_column :blog_entries, :entrepeneur1_id
  end

  def self.down
  	  remove_column :blog_entries, :summary
  end
end
