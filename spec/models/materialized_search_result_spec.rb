require 'spec_helper'

RSpec.describe MaterializedSearchResult, type: :model do
  before(:all) do
    populate_5_activities_1
    MaterializedSearchResult.refresh
  end

  describe "#new" do
    it "has matching objects" do
      result = MaterializedSearchResult.new("searchkick")
      result.each do |t|
        expect(t.title.include? "Searchkick").to be_truthy
      end
    end

    it "search results with given boolean options" do
      result = MaterializedSearchResult.new("",{camp: true})
      result.each do |t|
        expect(t.title.include? "Searchkick").to be_truthy
        expect(t.camp).to be_truthy
      end
    end

  end

  describe 'scopes' do
    it 'can search with scopes' do
      result = MaterializedSearchResult.camp.map(&:searchable)
      result.each do |t|
        expect(t.camp).to be_truthy
      end
    end

    it 'can chain scopes' do
      result = MaterializedSearchResult.drop_in.camp.map(&:searchable)
      result.each do |t|
        expect(t.camp).to be_truthy
        expect(t.drop_in).to be_truthy
      end
    end
  end
end
