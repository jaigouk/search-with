class Tag < ApplicationRecord
	has_many :activity_tags
  has_many :activities, through: :activity_tags
end
