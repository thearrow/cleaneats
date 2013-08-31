require 'spec_helper'

describe Feature do
  it 'should initialize' do
    feature = FactoryGirl.build(:feature)
    expect(feature.gluten).to eq(1.5)
    expect(feature.dairy).to eq(4.0)
  end
end
