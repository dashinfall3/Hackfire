class CreateInvestments < ActiveRecord::Migration
  def self.up
    create_table :investments do |t|
      t.integer :amount
      t.string :series
      t.integer :company_id
      t.integer :financial_organization_id
      t.date :date
      t.string :currency

      t.timestamps
    end
    add_index :investments, :company_id
    add_index :investments, :financial_organization_id
  end

  def self.down
    drop_table :investments
  end
end
