FactoryBot.define do
  factory :room do
    user { create(:user) }
    sequence(:name)        { |n| "Room_#{n}" }
    sequence(:description) { |n| "DESCRIPTION_#{n}" }
    user_id { user.id }
  end
end
