class Location < ApplicationRecord
  has_one :activity_location
  has_one :activity, through: :activity_location
end
