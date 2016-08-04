require 'spec_helper'

RSpec.describe Tag, type: :model do
  let(:tag) { create(:tag) }
  let(:activity) { create(:activity) }
  let(:activity_tag) { create(:activity_tag, tag: tag, activity: activity) }

  describe 'associations' do
    it { should have_many(:activities).through(:activity_tags) }
  end
end
