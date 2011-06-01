class EmployeeRelationship < ActiveRecord::Base
	attr_accessible :employee_id, :company_id
	
	belongs_to :startup
	belongs_to :employee
	
	validates :employee_id, :presence => true
	validates :company_id, :presence => true
end
