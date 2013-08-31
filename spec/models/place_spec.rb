require 'spec_helper'

describe Place do
  let(:place) { FactoryGirl.create :place }
  let(:feature) { FactoryGirl.create :feature }

  it 'should initialize' do
    expect(place.id_citygrid).to eq("CityGridId")
  end

  it 'should take features' do
    place.features << feature
    expect(place.features.count).to eq(1)
  end

  it 'should average all features' do
    place.features << FactoryGirl.create(:feature, gluten: 1.0)
    place.features << FactoryGirl.create(:feature, gluten: 2.0)
    place.features << FactoryGirl.create(:feature, gluten: 3.0)

    place2 = FactoryGirl.create(:place)
    place2.features << FactoryGirl.create(:feature, gluten: 99.0)

    expect(place.feature.gluten).to eq(2.0)
  end
end
