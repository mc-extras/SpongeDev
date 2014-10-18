require 'spec_helper'

describe Plugin do
  let(:plugin) { FactoryGirl.create(:plugin) }

  subject { plugin }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:body) }
  it { should validate_presence_of(:summary) }
  it { should validate_presence_of(:license) }
  it { should validate_uniqueness_of(:name) }
  it { should validate_inclusion_of(:primary_category).in_array(CATEGORIES) }
end