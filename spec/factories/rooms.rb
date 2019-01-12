FactoryBot.define do
  factory :room do
    user { create(:user) }
    folder { create(:folder) }
    sequence(:name)        { |n| "Room_#{n}" }
    sequence(:description) { |n| "DESCRIPTION_#{n}" }
    user_id { user.id }
    folder_id { folder.id }
  end
end
