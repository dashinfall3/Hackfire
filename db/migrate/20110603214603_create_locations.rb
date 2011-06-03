class CreateLocations < ActiveRecord::Migration
  def self.up
    create_table :locations do |t|
	  t.integer :startup_id
	  t.string :description
      t.string :address
      t.integer :zip_code
      t.string :city
      t.string :state
      t.string :country
      t.float :latitude
      t.float :longitude
      t.timestamps
    end
      add_index :locations, :startup_id
  end

  def self.down
    drop_table :locations
  end
end
