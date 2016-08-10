require 'spec_helper'

RSpec.describe GetFacetsSearchResults do
  let(:params) do
    {q: "searchkick", camp: "false", page: 1, per_page: 5}
  end

  before(:all) do
    populate_5_activities_1
    MaterializedSearchResult.refresh

    @benchmark = CompareSearchMethods.new()
  end

  describe 'self.new' do
    it 'has search methods' do
      expect(@benchmark.elastic.type).to eq :elastic
      expect(@benchmark.materialized.type).to eq :materialized
    end
  end

  describe 'self.call' do
    it 'returns benchmarking results' do
      benchmark = @benchmark.call(params: params, time: 5, warmup: 2)
      expect(benchmark[:entries].size).to eq 4
      expect(benchmark[:result].include? 'Materialized').to be_truthy
      expect(benchmark[:result].include? 'ElasticSeach').to be_truthy
      expect(benchmark[:data].map{|x| x["name"]}.sort).to eq(
        ["Algolia", "ElasticSeach", "Materialized", "Solr"]
      )
    end
  end
end
