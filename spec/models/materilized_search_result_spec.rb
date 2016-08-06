require 'spec_helper'

RSpec.describe MaterilizedSearchResult, type: :model do
  before(:all) do
    populate_5_activities_1
    MaterilizedSearchResult.refresh
  end

  describe "#new" do
    it "has matching objects" do
      result = MaterilizedSearchResult.new("searchkick")
      result.each do |t|
        expect(t.title.include? "Searchkick").to be_truthy
      end
    end

    it "search results with given boolean options" do
      result = MaterilizedSearchResult.new("searchkick", {searchable_camp: true})
      result.each do |t|
        expect(t.title.include? "Searchkick").to be_truthy
        expect(t.camp).to be_truthy
      end
    end
  end

  describe 'scopes' do
    it 'can search with scopes' do
      result = MaterilizedSearchResult.camp.map(&:searchable)
      result.each do |t|
        expect(t.camp).to be_truthy
      end
    end

    it 'can chain scopes' do
      result = MaterilizedSearchResult.drop_in.camp.map(&:searchable)
      result.each do |t|
        expect(t.camp).to be_truthy
        expect(t.drop_in).to be_truthy
      end
    end
  end
end
