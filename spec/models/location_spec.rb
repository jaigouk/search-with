require 'spec_helper'

RSpec.describe Location, type: :model do
  let(:activity) { create(:activity) }
  let(:location) { create(:location)}
  let(:activity_location) { create(:activity_location, location: location, activity: activity)}

  describe 'associations' do
    it { should have_one(:activity) }
  end
end
