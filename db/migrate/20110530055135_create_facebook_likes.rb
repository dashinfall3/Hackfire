class CreateFacebookLikes < ActiveRecord::Migration
  def self.up
    create_table :facebook_likes do |t|
      t.integer :company_id
      t.date :date
      t.integer :likes

      t.timestamps
    end
    add_index :facebook_likes, :company_id
  end

  def self.down
    drop_table :facebook_likes
  end
end
