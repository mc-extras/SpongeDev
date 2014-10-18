require 'spec_helper'

describe Comment do
  let(:user) { FactoryGirl.create(:user) }
  let(:plugin) { FactoryGirl.create(:plugin, :user => user) }
  let(:comment) { FactoryGirl.create(:comment, :user => user, :plugin => plugin) }

  subject { comment }
  it { should validate_presence_of(:content) }
  it { should belong_to(:user) }
  it { should belong_to(:plugin) }
end