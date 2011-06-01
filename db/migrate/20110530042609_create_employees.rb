class CreateEmployees < ActiveRecord::Migration
  def self.up
    create_table :employees do |t|
      t.string :name
      t.boolean :business
      t.boolean :technical
      t.integer :score
      t.integer :investment_score
      t.integer :exit_score
      t.integer :experience_score
      t.text :notes

      t.timestamps
    end
    
    add_index :employees, :name
  end

  def self.down
    drop_table :employees
  end
end
