require 'spec_helper'

RSpec.describe HomeController, type: :controller do
  render_views
  let(:result) { JSON.parse(response.body) }

  before(:all) do
    populate_5_activities_2
  end

  describe '#elastic' do
    it 'returns all activities without any query' do
      get :elastic, format: 'json', params: { q: "Searchkick" }
      expect(result['data'].count).to eq 5
    end

    it 'returns activities with a matching query' do
      get :elastic, format: 'json', params: { q: "starwars" }
      expect(result['data'].count).to eq 3
    end

    it 'returns activities with a query for about colum' do
      get :elastic, format: 'json', params: { q: "Master Yoda" }
      expect(result['data'].count).to eq 1
    end

    it 'returns all activities with a facet option camp' do
      get :elastic, format: 'json', params: { camp: "false" }
      expect(result['data'].count).to eq 3
      result['data'].each do |item|
        expect(result['data'].first['attributes']['tags'].include? 'camp').to be_falsey
      end
    end

    it 'accpts true as a filter' do
      get :elastic, format: 'json', params: { camp: "true" }
      expect(result['data'].count).to eq 2
    end

    it 'returns all activities with a facet option indoor' do
      get :elastic, format: 'json', params: { indoor: "true" }
      expect(result['data'].count).to eq 5
    end

    it 'accepts mixed filters' do
      get :elastic, format: 'json', params: {camp: "false", indoor: "true" }
      expect(result['data'].count).to eq 3
    end

  end
end
