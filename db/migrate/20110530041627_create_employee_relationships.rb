class CreateEmployeeRelationships < ActiveRecord::Migration
  def self.up
    create_table :employee_relationships do |t|
      t.integer :employee_id
      t.integer :company_id
      t.integer :tenure
      t.string :position
      t.boolean :through_exit
      t.date :date_joined
      t.date :date_left

      t.timestamps
    end
    
    add_index :employee_relationships, :company_id
    add_index :employee_relationships, :employee_id
    add_index :employee_relationships, [:company_id, :employee_id], :unique => true
  end

  def self.down
    drop_table :employee_relationships
  end
end
