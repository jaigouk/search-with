require 'spec_helper'

RSpec.describe Activity, type: :model do
  let(:tag) { create(:tag) }
  let(:activity) { create(:activity) }
  let(:activity_tag) { create(:activity_tag, tag: tag, activity: activity) }
  let(:location) { create(:location)}
  let(:activity_location) { create(:activity_location, location: location, activity: activity)}

  describe 'associations' do
    it { should have_many(:tags).through(:activity_tags) }
    it { should have_one(:location).through(:activity_location) }
  end
end
