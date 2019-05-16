require 'rails_helper'

RSpec.describe HomesController, type: :routing do
  it 'routes to #show' do
    expect(get: '/').to route_to('controller' => 'homes', 'action' => 'index')
  end
end
