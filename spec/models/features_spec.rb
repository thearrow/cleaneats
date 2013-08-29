require 'spec_helper'

describe Features do
  it 'should initialize' do
    features = FactoryGirl.build(:features)
    features.gluten.should eq(1.5)
    features.dairy.should eq(4.0)
  end
end
