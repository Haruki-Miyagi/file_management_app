require 'rails_helper'

RSpec.describe DocumentsController, type: :routing do
  let(:admin_user) { create(:user, :admin) }
  let(:root) { create(:folder, name: 'Root', description: 'Root Folder', user_id: admin_user.id) }
  let(:room) { create(:room, user_id: admin_user.id, folder_id: root.id) }
  let(:document) { create(:document, user_id: admin_user.id, room_id: resource.id) }

  it 'routes to #new' do
    expect(get: "/rooms/#{room.id}/documents/new").to route_to(
      'controller' => 'documents', 'action' => 'new', 'room_id' => room.id.to_s
    )
  end

  it 'routes to #create' do
    expect(post: "/rooms/#{room.id}/documents").to route_to(
      'controller' => 'documents', 'action' => 'create', 'room_id' => room.id.to_s
    )
  end
end
