FactoryBot.define do

  factory :match do
    host "Poland"
    guest "Germany"
    score "2:1"
    date "2018-07-24 18:00:00"
  end

  factory :user do
    email "example@example.com"
    password "password"
    trait :normal do
      role 0
    end
    trait :admin do
      role 1
    end
  end
end