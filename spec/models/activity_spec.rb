require 'spec_helper'

RSpec.describe Activity, type: :model do
  let(:tag) { create(:tag) }
  let(:activity) { create(:activity) }
  let(:activity_tag) { create(:activity_tag, tag: tag, activity: activity) }
  let(:location) { create(:location)}
  let(:activity_location) { create(:activity_location, location: location, activity: activity)}

  before(:all) do
    populate_5_activities_1
    MaterializedSearchResult.refresh
  end

  describe 'associations' do
    it { should have_many(:tags).through(:activity_tags) }
    it { should have_one(:location).through(:activity_location) }
  end

  describe 'options' do
    it 'returns options array that are enabled' do
      act = create(:activity, camp: false, outdoor: false, indoor: false,
        drop_in: true, date_night: true)
      expect(act.options).to eq  ["drop_in", "date_night"]
    end
  end
end
