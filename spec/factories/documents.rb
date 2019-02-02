FactoryBot.define do
  factory :document do
    user { create(:user) }
    room { create(:room) }
    sequence(:file_name) { |n| "Document_file_#{n}" }
    uploaded_file do
      Rack::Test::UploadedFile.new(
        Rails.root.join('spec', 'up_folder', 'file01.xlsx'), 'application/vnd.ms-excel'
      )
    end
    sequence(:description) { |n| "DESCRIPTION_file_#{n}" }
    user_id { user.id }
    room_id { room.id }
  end
end
