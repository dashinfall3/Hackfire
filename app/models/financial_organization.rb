class FinancialOrganization < ActiveRecord::Base
	attr_accessible :name, :series, :type, :permalink, :investments_number
	has_many :investments, :foreign_key => "financial_organization_id",
									  :dependent => :destroy
									  
	has_many :startups, :through => :investments
end
