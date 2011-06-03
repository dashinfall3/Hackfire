class Milestone < ActiveRecord::Base
	attr_accessible :startup_id, :type, :description, :date
	belongs_to :startup
end
