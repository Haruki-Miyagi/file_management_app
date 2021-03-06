FactoryBot.define do
  pass = Faker::Internet.password(8)

  factory :user do
    email                 { Faker::Internet.email }
    password              { pass }
    password_confirmation { pass }

    trait :admin do
      admin { true }
    end
  end
end
