class Employee < ActiveRecord::Base
	attr_accessible :name, :permalink
	has_many :employee_relationships, :foreign_key => "employee_id",
									  :dependent => :destroy
									  
	has_many :startups, :through => :employee_relationships
end
