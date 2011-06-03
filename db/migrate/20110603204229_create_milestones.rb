class CreateMilestones < ActiveRecord::Migration
  def self.up
    create_table :milestones do |t|
      t.integer :startup_id
      t.string :type
      t.text :description
      t.date :date
      t.string :source

      t.timestamps
    end
    	add_index :milestones, :startup_id
  end

  def self.down
    drop_table :milestones
  end
end
