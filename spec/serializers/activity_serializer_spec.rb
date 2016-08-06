require 'spec_helper'

RSpec.describe ActivitySerializer do
  before do
    Activity.delete_all
    tag = create(:tag)
    activity = create(:activity)
    location = create(:location)

    create(:activity_tag, tag: tag, activity: activity)
    create(:activity_location, location: location, activity: activity)
    Activity.reindex
  end

  let(:activity) do
    ActiveModelSerializers::SerializableResource.new(Activity.last, {}).as_json
  end

  it "has basic info " do
    expect(activity[:data][:attributes][:title]).to eq Activity.last.title
    expect(activity[:data][:attributes][:about]).to eq Activity.last.about
    expect(activity[:data][:attributes][:options]).to eq Activity.last.options.join(', ')
    expect(activity[:data][:attributes][:tags]).to eq Activity.last.tags.map(&:title)
    expect(activity[:data][:attributes][:location][:addr]).to eq Activity.last.location.line1
  end
end
