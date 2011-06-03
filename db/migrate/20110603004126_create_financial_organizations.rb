class CreateFinancialOrganizations < ActiveRecord::Migration
  def self.up
    create_table :financial_organizations do |t|
      t.string :name
      t.integer :investments_number
      t.string :type
      t.integer :investments_amount
      t.integer :exits
      t.integer :exits_amount

      t.timestamps
    end
    add_index :financial_organizations, :name
  end

  def self.down
    drop_table :financial_organizations
  end
end
