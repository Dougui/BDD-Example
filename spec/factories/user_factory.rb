FactoryGirl.define do
  factory :user do |f|
    f.sequence(:id) { |n| n}
    f.sequence(:username){ |n| "dougui#{n}"}
    f.password "test"
    f.password_confirmation "test"
    f.sequence(:email){ |n| "guirec.corbel#{n}@gmail.com"}
  end
end