require 'rails_helper'

RSpec.describe UserControllRoomsController, type: :routing do
  let(:admin_user) { create(:user, :admin) }
  let(:root) { create(:folder, name: 'Root', description: 'Root Folder', user_id: admin_user.id) }
  let(:room) { create(:room, user_id: admin_user.id, folder_id: root.id) }
  let(:user_controll_room) { create(:user_controll_room, user_id: admin_user.id, room_id: room.id) }

  it 'routes to #create' do
    expect(post: '/user_controll_rooms').to route_to(
      'controller' => 'user_controll_rooms', 'action' => 'create'
    )
  end

  it 'routes to #destroy' do
    expect(delete: "/user_controll_rooms/#{user_controll_room.id}").to route_to(
      'controller' => 'user_controll_rooms', 'action' => 'destroy', 'id' => user_controll_room.id.to_s
    )
  end
end
