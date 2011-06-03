class AddPermalinkToFinancialOrganizations < ActiveRecord::Migration
  def self.up
  	add_column :financial_organizations, :permalink, :string
  end

  def self.down
  	remove_column :financial_organizations, :permalink
  end
end
