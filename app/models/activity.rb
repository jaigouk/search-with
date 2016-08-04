class Activity < ApplicationRecord
	has_many :activity_tags
  has_many :tags, through: :activity_tags
  has_one :activity_location
  has_one :location, through: :activity_location
end
