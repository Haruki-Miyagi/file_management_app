require 'rails_helper'

RSpec.describe DocumentsHelper, type: :helper do
  let(:admin_user) { create(:user, :admin) }
  let(:root) { create(:folder, name: 'Root', description: 'Root Folder', user_id: admin_user.id) }
  let(:room) { create(:room, user_id: admin_user.id, folder_id: root.id) }

  describe 'update_pagination_partial_path' do
    let!(:documents) { create_list(:document, 30, user_id: admin_user.id, room_id: room.id) }
    before { assign(:documents, documents) }

    context 'next_pageが2のとき' do
      it 'パスを指定すること' do
        documents = double('documents', next_page: 2)
        expect(helper.update_pagination_partial_path(documents)).to eq('rooms/rooms_pagination_page/update_pagination')
      end
    end

    context 'next_pageがnilのとき' do
      it 'パスを指定すること' do
        documents = double('documents', next_page: nil)
        expect(helper.update_pagination_partial_path(documents)).to eq('rooms/rooms_pagination_page/remove_pagination')
      end
    end
  end
end
