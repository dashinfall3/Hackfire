class Person < ActiveRecord::Base
	attr_accessible :name, :permalink, :investments
	has_many :employee_relationships, :foreign_key => "employee_id",
									  :dependent => :destroy
									  
	has_many :startups, :through => :employee_relationships
	
	has_many :investments, :foreign_key => "financial_organization_id",
									  :dependent => :destroy
									  
	has_many :startups, :through => :investments
end
