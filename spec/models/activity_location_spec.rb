require 'spec_helper'

RSpec.describe ActivityLocation, type: :model do
  let(:activity) { create(:activity) }
  let(:location) { create(:location)}
  let(:activity_location) { create(:activity_location, location: location, activity: activity)}

  describe 'associations' do
    it { should belong_to(:activity) }
    it { should belong_to(:location) }
  end
end
