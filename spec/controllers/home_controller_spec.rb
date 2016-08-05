require 'spec_helper'

RSpec.describe HomeController, type: :controller do
  render_views
  let(:response_json) { JSON.parse(response.body) }

  before(:all) do
    populate_5_activities_2
  end

  describe '#elastic' do
    it 'returns all activities without any query' do
      get :elastic, format: 'json', params: { q: "Searchkick" }
      expect(response_json['data'].count).to eq 5
    end

    it 'returns activities with a matching query' do
      get :elastic, format: 'json', params: { q: "starwars" }
      expect(response_json['data'].count).to eq 3
    end

    it 'returns activities with a query for about colum' do
      get :elastic, format: 'json', params: { q: "Master Yoda" }
      expect(response_json['data'].count).to eq 1
    end

    it 'returns all activities with a facet option camp' do
      get :elastic, format: 'json', params: { camp: "false" }
      expect(response_json['data'].count).to eq 3
    end

    it 'returns all activities with a facet option indoor' do
      get :elastic, format: 'json', params: { indoor: "true" }
      expect(response_json['data'].count).to eq 5
    end

  end
end
