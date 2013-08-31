# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :place do
    id_citygrid "CityGridId"
    id_yelp "YelpId"
    id_google "GoogleId"
  end
end
