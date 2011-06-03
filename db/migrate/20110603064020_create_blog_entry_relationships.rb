class CreateBlogEntryRelationships < ActiveRecord::Migration
  def self.up
    create_table :blog_entry_relationships do |t|
      t.integer :blog_entry_id
      t.integer :company_id
      t.timestamps
    end
      add_index :blog_entry_relationships, :blog_entry_id
      add_index :blog_entry_relationships, :company_id
  end

  def self.down
    drop_table :blog_entry_relationships
  end
end
