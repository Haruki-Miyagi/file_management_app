require 'rails_helper'

RSpec.describe 'folders/_folder_table.html.erb', type: :view do
  let(:admin_user) { create(:user, :admin) }
  let(:root) { create(:folder, name: 'Root', description: 'Root Folder', user_id: admin_user.id) }
  let!(:resources) { create_list(:folder, 2, parent_id: root.id) }

  before do
    allow(view).to receive(:current_user).and_return(admin_user)
    render partial: 'folders/folder_table', locals: { resources: resources }
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

    it '編集があること' do
      assert_select 'table.table' do
        assert_select 'thead th', text: '編集', count: 1
      end
    end

    it '削除があること' do
      assert_select 'table.table' do
        assert_select 'thead th', text: '削除', count: 1
      end
    end
  end

  context 'テーブル本体' do
    it 'リンク付きのファイルのテキストがあること' do
      resources.each do |resource|
        assert_select 'table.table' do
          assert_select 'tbody td a[href=?]', folder_path(resource), text: resource.name
        end
      end
    end

    it '備考のテキストがあること' do
      resources.each do |resource|
        assert_select 'table.table' do
          assert_select 'tbody td', text: resource.description
        end
      end
    end

    context '編集' do
      it 'リンク付きの編集アイコンがあること' do
        resources.each do |resource|
          assert_select 'table.table' do
            assert_select 'tbody td a[href=?]', edit_folder_path(resource) do
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
      resources.each do |resource|
        assert_select 'table.table' do
          assert_select 'tbody td a[href=?][data-method="delete"]', "/folders/#{resource.id}" do
            assert_select 'i[class=?]', 'glyphicon glyphicon-trash'
          end
        end
      end
    end
  end
end
