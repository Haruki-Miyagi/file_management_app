require 'rails_helper'

RSpec.describe RoomsController, type: :routing do
  it 'routes to #show' do
    expect(get: '/rooms/1').to route_to('rooms#show', id: '1')
  end

  it 'routes to #new' do
    expect(get: 'rooms/new').to route_to('rooms#new')
  end

  it 'routes to #edit' do
    expect(get: '/rooms/1/edit').to route_to('rooms#edit', id: '1')
  end

  it 'routes to #create' do
    expect(post: '/rooms').to route_to('rooms#create')
  end

  it 'routes to #update' do
    expect(patch: '/rooms/1').to route_to('rooms#update', id: '1')
  end

  it 'routes to #destroy' do
    expect(delete: '/rooms/1').to route_to('rooms#destroy', id: '1')
  end
end
