class FacebookLike < ActiveRecord::Base
attr_accessible :likes, :date, :company_id
belongs_to :startup
end
