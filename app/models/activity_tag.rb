class ActivityTag < ApplicationRecord
	belongs_to :activity
	belongs_to :tag
end
