# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :comment do
    version_id 1
    text "MyString"
    start_time 1
  end
end
