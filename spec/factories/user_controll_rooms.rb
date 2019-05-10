FactoryBot.define do
  factory :user_controll_room do
    user { create(:user) }
    room { create(:room) }
  end
end
