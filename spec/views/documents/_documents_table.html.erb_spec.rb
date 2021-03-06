require 'rails_helper'

RSpec.describe 'documents/_documents_table.html.erb', type: :view do
  let(:admin_user) { create(:user, :admin) }
  let(:root) { create(:folder, name: 'Root', description: 'Root Folder', user_id: admin_user.id) }
  let(:resource) { create(:room, user_id: admin_user.id, folder_id: root.id) }
  let(:documents) { create_list(:document, 31, user_id: admin_user.id, room_id: resource.id) }

  before do
    assign(:documents, documents)
    assign(:resource, resource)
    allow(view).to receive_messages(will_paginate: nil)
    allow(view).to receive(:current_user).and_return(admin_user)
    render partial: 'documents/documents_table', locals: { resource: resource, documents: documents }
  end

  context 'テーブルヘッダ' do
    it 'ファイル名があること' do
      assert_select 'table.table' do
        assert_select 'thead th:nth-child(1).text-center', text: 'ファイル名', count: 1
      end
    end

    it '備考があること' do
      assert_select 'table.table' do
        assert_select 'thead th:nth-child(2).text-center', text: '備考', count: 1
      end
    end

    it '編集があること' do
      assert_select 'table.table' do
        assert_select 'thead th:nth-child(3).text-center', text: '編集', count: 1
      end
    end

    it '削除があること' do
      assert_select 'table.table' do
        assert_select 'thead th:nth-child(4).text-center', text: '削除', count: 1
      end
    end
  end

  context 'テーブル本体' do
    it 'リンク付きのファイルのテキストがあること' do
      documents.each do |document|
        assert_select 'table.table' do
          assert_select 'tbody td:nth-child(1)' do
            assert_select 'a[href=?]', room_document_path(resource, document), text: document.file_name
          end
        end
      end
    end

    it 'ダウンロード用のリンク付きアイコンがあること' do
      documents.each do |document|
        assert_select 'table.table' do
          assert_select 'tbody td:nth-child(1)' do
            assert_select 'a[href=?]', "/rooms/#{resource.id}/documents/#{document.id}/download" do
              assert_select 'i[class=?]', 'glyphicon glyphicon-download'
            end
          end
        end
      end
    end

    it '備考のテキストがあること' do
      documents.each do |document|
        assert_select 'table.table' do
          assert_select 'tbody td:nth-child(2)', text: document.description
        end
      end
    end

    context '編集' do
      it 'リンク付きの編集アイコンがあること' do
        documents.each do |document|
          assert_select 'table.table' do
            assert_select 'tbody td:nth-child(3) a[href=?]', edit_room_document_path(resource, document) do
              assert_select 'i[class=?]', 'glyphicon glyphicon-edit'
            end
          end
        end
      end

      it 'ポップアップメッセージがあること' do
        assert_select 'table.table td' do
          assert_select 'a[title=?]', '編集するにはクリックしてください'
          assert_select 'a[data-toggle=?]', 'tooltip'
        end
      end
    end

    it 'リンク付きの削除アイコンがあること' do
      documents.each do |document|
        assert_select 'table.table' do
          assert_select 'tbody td:nth-child(4) a[href=?][data-method="delete"]', room_document_path(resource, document) do
            assert_select 'i[class=?]', 'glyphicon glyphicon-trash'
          end
        end
      end
    end
  end
end
