class ChangePersonsToPeople < ActiveRecord::Migration
  def self.up
    drop_table :persons
  	create_table :people do |t|
      t.string :name
      t.boolean :business
      t.boolean :technical
      t.integer :score
      t.integer :investment_score
      t.integer :exit_score
      t.integer :experience_score
      t.text :notes
      t.integer :investments
      t.string :investor_type
      t.integer :investment_amount
      t.integer :investment_exits
      t.integer :investment_exits_amount

      t.timestamps
    end
    add_index :people, :name
  end

  def self.down
  	drop_table :people
  end
end
