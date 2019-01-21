require 'rails_helper'

RSpec.describe 'rooms/show.html.erb', type: :view do
  let(:user) { create(:user, :admin) }
  let(:root) { create(:folder, name: 'Root', description: 'Root Folder') }
  let(:resource) { create(:room, user_id: user.id, folder_id: root.id) }
  let(:messages) { create_list(:message, 3, room_id: resource.id) }

  before do
    assign(:resource, resource)
    assign(:messages, messages)
    render
  end

  it 'パネルタイトルがあること' do
    assert_select 'div.panel-heading' do
      assert_select 'h3.panel-title', text: "ファイル管理名 : #{resource.name}"
    end
  end

  it 'パネル内にメールアドレスがあること' do
    assert_select 'div.panel-body.pre-scrollable.scroll-bar' do
      assert_select 'div.col-md-4', text: messages.first.user.email.to_s
    end
  end

  it 'パネル内にメッセージ内容があること' do
    assert_select 'div.panel-body.pre-scrollable.scroll-bar' do
      assert_select 'div.bms_message_content p', text: messages.first.content.to_s
    end
  end
end
