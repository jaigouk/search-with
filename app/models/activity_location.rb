class ActivityLocation < ApplicationRecord
  belongs_to :activity
  belongs_to :location
end
