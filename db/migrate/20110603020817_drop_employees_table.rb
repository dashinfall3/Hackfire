class DropEmployeesTable < ActiveRecord::Migration
  def self.up
  	drop_table :employees
  	create_table :persons do |t|
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
    add_index :persons, :name
    
  end

  def self.down
  end
end
