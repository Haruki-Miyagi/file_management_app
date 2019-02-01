require 'rails_helper'

RSpec.describe 'documents/_add_document.html.erb', type: :view do
  let(:user) { create(:user, :admin) }
  let(:root) { create(:folder, name: 'Root', description: 'Root Folder') }
  let(:resource) { create(:room, user_id: user.id, folder_id: root.id) }

  before do
    render partial: 'documents/add_document', locals: { resource: resource }
  end

  context '追加ボタン' do
    context 'ファイル' do
      context 'ファイル追加ボタン' do
        it 'リンク付きであること' do
          assert_select 'ul.table-add-list li' do
            assert_select 'a[href=?]', "/rooms/#{resource.id}/documents/new"
            assert_select 'a', text: '+'
            assert_select 'i[class=?]', 'glyphicon glyphicon-copy'
          end
        end
      end

      it '新しくファイルを作成しますのポップアップメッセージがあること' do
        assert_select 'ul.table-add-list li' do
          assert_select 'a[title=?]', '新しくファイルを作成します'
          assert_select 'a[data-toggle=?]', 'tooltip'
        end
      end
    end
  end
end
