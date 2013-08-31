# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :feature, :class => 'Feature' do
    gluten 1.5
    msg 1.5
    dairy 4.0
    vegan 1.5
    vegetarian 1.5
    paleo 1.5
    low_carb 1.5
  end
end
