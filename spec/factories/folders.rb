FactoryBot.define do
  factory :folder do
    user { create(:user) }
    sequence(:name)        { |n| "TEST_FOLDER_#{n}" }
    sequence(:description) { |n| "TEST_DESCRIPTION_#{n}" }
    user_id { user.id }
  end
end
