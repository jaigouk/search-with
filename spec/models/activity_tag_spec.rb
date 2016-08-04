require 'spec_helper'

RSpec.describe ActivityTag, type: :model do
  let(:tag) { create(:tag) }
  let(:activity) { create(:activity) }
  let(:activity_tag) { create(:activity_tag, tag: tag, activity: activity) }

  describe 'associations' do
    it { should belong_to(:activity) }
    it { should belong_to(:tag) }
  end
end
