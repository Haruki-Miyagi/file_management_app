require 'rails_helper'

RSpec.describe DocumentsController, type: :routing do
  let(:admin_user) { create(:user, :admin) }
  let(:root) { create(:folder, name: 'Root', description: 'Root Folder', user_id: admin_user.id) }
  let(:room) { create(:room, user_id: admin_user.id, folder_id: root.id) }
  let(:document) { create(:document, user_id: admin_user.id, room_id: room.id) }

  it 'routes to #show' do
    expect(get: "/rooms/#{room.id}/documents/#{document.id}").to route_to(
      'controller' => 'documents', 'action' => 'show', 'room_id' => room.id.to_s, 'id' => document.id.to_s
    )
  end

  it 'routes to #new' do
    expect(get: "/rooms/#{room.id}/documents/new").to route_to(
      'controller' => 'documents', 'action' => 'new', 'room_id' => room.id.to_s
    )
  end

  it 'routes to #edit' do
    expect(get: "/rooms/#{room.id}/documents/#{document.id}/edit").to route_to(
      'controller' => 'documents', 'action' => 'edit', 'room_id' => room.id.to_s, 'id' => document.id.to_s
    )
  end

  it 'routes to #create' do
    expect(post: "/rooms/#{room.id}/documents").to route_to(
      'controller' => 'documents', 'action' => 'create', 'room_id' => room.id.to_s
    )
  end

  it 'routes to #update' do
    expect(patch: "/rooms/#{room.id}/documents/#{document.id}").to route_to(
      'controller' => 'documents', 'action' => 'update', 'room_id' => room.id.to_s, 'id' => document.id.to_s
    )
  end

  it 'routes to #destroy' do
    expect(delete: "/rooms/#{room.id}/documents/#{document.id}").to route_to(
      'controller' => 'documents', 'action' => 'destroy', 'room_id' => room.id.to_s, 'id' => document.id.to_s
    )
  end

  it 'routes to #download' do
    expect(get: "/rooms/#{room.id}/documents/#{document.id}/download").to route_to(
      'controller' => 'documents', 'action' => 'download', 'room_id' => room.id.to_s, 'id' => document.id.to_s
    )
  end
end
