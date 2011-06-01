class CreateBlogEntries < ActiveRecord::Migration
  def self.up
    create_table :blog_entries do |t|
      t.date :date
      t.text :title
      t.string :blog_name
      t.string :link

      t.timestamps
    end
  end

  def self.down
    drop_table :blog_entries
  end
end
