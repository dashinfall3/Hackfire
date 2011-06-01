class CreateTrafficPoints < ActiveRecord::Migration
  def self.up
    create_table :traffic_points do |t|
      t.integer :company_id
      t.date :date
      t.integer :unique_views
      t.integer :visits
      t.integer :pageviews
      t.integer :time_on_site
      t.integer :visits_person
      t.integer :pages_visit

      t.timestamps
    end
    add_index :traffic_points, :company_id
  end

  def self.down
    drop_table :traffic_points
  end
end
