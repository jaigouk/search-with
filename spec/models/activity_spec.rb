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

  describe 'self.facets_search' do
    before(:all) do
      Activity.delete_all
      5.times do |i|
        tag = create(:tag)
        activity = create(:activity, title: "Searchkick #{i}", camp: false, drop_in: true)
        location = create(:location)
        create(:activity_tag, tag: tag, activity: activity)
        create(:activity_location, location: location, activity: activity)
      end
      Activity.reindex
    end

    after do
      Activity.delete_all
    end

    it 'returns search results with query param' do
      expect(Activity.facets_search({q: "searchkick"}).count).to eq 5
    end

    it 'returns search results with page param' do
      expect(Activity.facets_search({q: "searchkick", page: 1, per_page: 2}).count).to eq 2
    end

    it 'returns search results with facets' do
      expect(Activity.facets_search({q: "searchkick", camp: false}).count).to eq 5
      expect(Activity.facets_search({q: "searchkick", camp: "true"}).count).to eq 0
    end
  end
end
