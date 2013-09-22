# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    provider "MyString"
    uid "MyString"
    name "MyString"
    email "MyString"
    image_url "MyString"
    oauth_token "MyString"
    oauth_expires_at "2013-09-22 13:24:32"
  end
end
