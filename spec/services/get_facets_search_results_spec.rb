require 'spec_helper'
RSpec.describe GetFacetsSearchResults do
  let(:params) do
    {q: "searchkick", camp: "false", page: 1, per_page: 5}
  end

  let(:camp_true_params) do
    {q: "searchkick", camp: "true", page: 1, per_page: 5}
  end

  let(:no_result_params) do
    {q: "Dark Ages", camp: "true", page: 1, per_page: 5}
  end

  let(:per_page_2_params_page_1) do
    {q: "searchkick", camp: "true", page: 1, per_page: 2}
  end

  let(:per_page_2_params_page_2) do
    {q: "searchkick", camp: "true", page: 2, per_page: 2}
  end

  before(:all) do
    populate_5_activities_1
    MaterializedSearchResult.refresh

    @elastic = GetFacetsSearchResults.new(:elastic)
    @materialized = GetFacetsSearchResults.new(:materialized)
  end

  describe 'self.new' do
    it 'has a search type' do
      expect(@elastic.type).to eq :elastic
      expect(@materialized.type).to eq :materialized
    end
  end

  # describe 'self.call' do
  #   it 'returns search results with params' do
  #     expect(@elastic.call(params).size).to eq 2
  #     expect(@elastic.call(camp_true_params).size).to eq 3
  #     expect(@elastic.call(no_result_params).size).to eq 0
  #   end

  #   it 'returns the same resuls for any search methods with same params' do
  #     expect(@elastic.call(params).size).to eq 2
  #     expect(@elastic.call(camp_true_params).size).to eq 3
  #     expect(@elastic.call(no_result_params).size).to eq 0

  #     expect(@materialized.call(params).size).to eq 2
  #     expect(@materialized.call(camp_true_params).size).to eq 3
  #     expect(@materialized.call(no_result_params).size).to eq 0
  #   end

  #   it 'returns paginated results' do
  #     expect(@elastic.call(per_page_2_params_page_1).size).to eq 2
  #     expect(@elastic.call(per_page_2_params_page_2).size).to eq 1

  #     expect(@materialized.call(per_page_2_params_page_1).size).to eq 2
  #     expect(@materialized.call(per_page_2_params_page_2).size).to eq 1
  #   end
  # end
end
