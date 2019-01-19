FactoryBot.define do
  factory :message do
    user { create(:user) }
    room { create(:room) }
    sequence(:content) { |n| "Message_#{n}" }
    user_id { user.id }
    room_id { room.id }
  end
end
