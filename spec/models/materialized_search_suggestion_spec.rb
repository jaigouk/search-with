require 'spec_helper'

RSpec.describe MaterializedSearchSuggestion, type: :model do
  before(:all) do
    populate_5_activities_1
    MaterializedSearchResult.refresh
  end

  describe "#terms_for" do
    it "returns matching titles" do
      MaterializedSearchSuggestion.clear
      MaterializedSearchSuggestion.seed
      result = MaterializedSearchSuggestion.terms_for("searchkick")
      expect(result.size).to eq 5
      result.each do |item|
        expect(item.include? "searchkick").to be_truthy
      end
    end

    it "returns title with a part of matching chars" do
      MaterializedSearchSuggestion.clear
      MaterializedSearchSuggestion.seed
      result = MaterializedSearchSuggestion.terms_for("sear")
      expect(result.size > 0).to be_truthy
    end
  end

  describe "#clear" do
    it "deltes the data" do
      MaterializedSearchSuggestion.clear
      MaterializedSearchSuggestion.seed
      result = MaterializedSearchSuggestion.terms_for("sear")
      expect(result.size > 0).to be_truthy
      MaterializedSearchSuggestion.clear
      result_1 = MaterializedSearchSuggestion.terms_for("searchkick")
      expect(result_1.size).to eq 0
    end
  end
end
