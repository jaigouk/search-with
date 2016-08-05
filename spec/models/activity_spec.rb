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
        bool = (1..3).include?(i) ? true : false
        activity = create(:activity, title: "Searchkick #{i}", camp: bool, drop_in: true)
        location = create(:location)
        create(:activity_tag, tag: tag, activity: activity)
        create(:activity_location, location: location, activity: activity)
      end
      Activity.reindex
    end

    after do
      Activity.delete_all
    end

    # it 'returns search results with query param' do
    #   expect(Activity.facets_search({q: "searchkick"}).count).to eq 5
    # end

    # it 'returns search results with page param' do
    #   expect(Activity.facets_search({q: "searchkick", page: 1, per_page: 2}).count).to eq 2
    # end

    # it 'returns search results with facets' do
    #   falses = Activity.facets_search({q: "searchkick", camp: "false"})
    #   trues = Activity.facets_search({q: "searchkick", camp: "true"})
    #   expect(falses.count).to eq 2
    #   expect(trues.count).to eq 3
    # end
  end
end
