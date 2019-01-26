require 'rails_helper'

RSpec.describe 'documents/_documents_table.html.erb', type: :view do
  let(:user) { create(:user, :admin) }
  let(:root) { create(:folder, name: 'Root', description: 'Root Folder') }
  let(:resource) { create(:room, user_id: user.id, folder_id: root.id) }
  let(:documents) { create_list(:document, 3, user_id: user.id, room_id: resource.id) }

  before do
    render partial: 'documents/documents_table', locals: { resource: resource, documents: documents }
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

    context 'ポップアップメッセージ' do
      it 'スクリプトがあること' do
        assert_select 'script', /data-toggle/
        assert_select 'script', /tooltip/
      end

      it 'pcとモバイルで表示法をわけてあること' do
        assert_select 'script', /navigator.userAgent/
      end
    end
  end

  context 'テーブルヘッダ' do
    it 'ファイル名があること' do
      assert_select 'table.table' do
        assert_select 'thead th', text: 'ファイル名', count: 1
      end
    end

    it '備考があること' do
      assert_select 'table.table' do
        assert_select 'thead th', text: '備考', count: 1
      end
    end
  end

  context 'テーブル本体' do
    it 'リンク付きのファイルのテキストがあること' do
      documents.each do |document|
        assert_select 'table.table' do
          assert_select 'tbody td', text: document.file_name
        end
      end
    end

    it '備考のテキストがあること' do
      documents.each do |document|
        assert_select 'table.table' do
          assert_select 'tbody td', text: document.description
        end
      end
    end
  end
end
