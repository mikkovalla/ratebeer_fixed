FactoryGirl.define do
  factory :user do
    username "Pekka"
    password "Foobar1"
    password_confirmation "Foobar1"
  end

  factory :user2 do
    username "Seppo"
    password "Salis1"
    password_confirmation "Salis1"
  end

  factory :rating do
    score 10
  end

  factory :rating2, class: Rating do
    score 20
  end

  factory :brewery do
    name "anonymous"
    year 1900
    active true
  end

  factory :style do
    name "Lager"
    description "empty"
  end

  factory :beer do
    name "anonymous"
    brewery
    style
  end
end