require 'spec_helper'

RSpec.describe HomeController, type: :controller do
  render_views
  let(:response_json) { JSON.parse(response.body) }

  before(:all) do
    Activity.delete_all
    5.times do |i|
      query = (1..3).include?(i) ? "Starwars" : "Startreck"
      about = "Master Yoda said, Do. Or do not. There is no try." if i == 3
      bool = (2..3).include?(i) ? true : false

      tag = create(:tag)
      activity = create(:activity, title: "Searchkick #{query}", about: about, camp: bool)
      location = create(:location)

      create(:activity_tag, tag: tag, activity: activity)
      create(:activity_location, location: location, activity: activity)
    end
    Activity.reindex
  end

  describe '#elastic' do
    # it 'returns all activities without any query' do
    #   get :elastic, format: 'json', params: { q: "Searchkick" }
    #   expect(response_json['data'].count).to eq 5
    # end

    # it 'returns activities with a matching query' do
    #   get :elastic, format: 'json', params: { q: "starwars" }
    #   expect(response_json['data'].count).to eq 3
    # end

    # it 'returns activities with a query for about colum' do
    #   get :elastic, format: 'json', params: { q: "Master Yoda" }
    #   expect(response_json['data'].count).to eq 1
    # end

    it 'returns all activities without any query' do
      # get :elastic, format: 'json', params: { camp: "false" }
      # expect(response_json['data'].count).to eq 3

      get :elastic, format: 'json', params: { camp: "true" }
      expect(response_json['data'].count).to eq 2
    end

  end
end
