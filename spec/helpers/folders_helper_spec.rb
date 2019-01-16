require 'rails_helper'

RSpec.describe FoldersHelper, type: :helper do
  let(:admin_user) { create(:user, :admin) }
  let!(:root) { create(:folder, name: 'Root', description: 'Root Folder', user_id: admin_user.id) }

  describe 'display_icon_status' do
    let(:f_resource) { create(:folder, user_id: admin_user.id) }
    let(:r_resource) { create(:room, user_id: admin_user.id, folder_id: root.id) }

    context 'folderインスタンスの場合' do
      it 'フォルダicon画像のクラスがかえること' do
        expect(helper.display_icon_status(f_resource)).to eq('glyphicon-folder-close')
      end
    end

    context 'roomインスタンスの場合' do
      it 'roomフォルダicon画像のクラスがかえること' do
        expect(helper.display_icon_status(r_resource)).to eq('glyphicon-list-alt')
      end
    end
  end

  describe 'display_icon_status' do
    let(:f_resource) { create(:folder, user_id: admin_user.id) }
    let(:r_resource) { create(:room, user_id: admin_user.id, folder_id: root.id) }

    context 'folderインスタンスの場合' do
      it 'フォルダの編集画面へのパスがかえると' do
        expect(helper.change_instance_redirect(f_resource)).to eq(edit_folder_path(f_resource))
      end
    end

    context 'roomインスタンスの場合' do
      it 'roomフォルダの編集画面へのパスがかえると' do
        expect(helper.change_instance_redirect(r_resource)).to eq(edit_room_path(r_resource))
      end
    end
  end
end
