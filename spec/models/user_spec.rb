require 'spec_helper'

describe User do
  let(:user) { FactoryGirl.create(:user) }

  subject { user }
  it { should validate_presence_of(:email) }
  it { should validate_uniqueness_of(:email) }
  it { should have_many(:plugins) }
  it { should have_many(:comments) }
end