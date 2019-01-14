require 'rails_helper'

RSpec.describe 'folders/index.html.erb', type: :view do
  let(:admin_user) { create(:user, :admin) }
  let(:root) { create(:folder, name: 'Root', description: 'Root Folder', user_id: admin_user.id) }
  let!(:resources) { create_list(:folder, 2, parent_id: root.id) }

  before do
    allow(view).to receive(:current_user).and_return(admin_user)
    assign(:resource, root)
    assign(:resources, resources)
    render
  end

  context '追加ボタン' do
    context 'フォルダ' do
      context 'フォルダ追加ボタン' do
        it 'リンク付きであること' do
          assert_select 'ul.table-add-list li' do
            assert_select 'a[href=?]', "/folders/new?parent_id=#{root.id}"
            assert_select 'a', text: '+'
            assert_select 'i[class=?]', 'glyphicon glyphicon-folder-close'
          end
        end
      end

      context 'ポップアップメッセージ' do
        it '新しくフォルダを作成しますのポップアップメッセージのテキストがあること' do
          assert_select 'ul.table-add-list li' do
            assert_select 'a[title=?]', '新しくフォルダを作成します'
            assert_select 'a[data-toggle=?]', 'tooltip'
          end
        end
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
    it 'リンク付きのファイルのテキストがある表示してあること' do
      resources.each do |resource|
        assert_select 'table.table' do
          assert_select 'tbody td a[href=?]', folder_path(resource), text: resource.name
        end
      end
    end

    it '備考のテキストがある表示してあること' do
      resources.each do |resource|
        assert_select 'table.table' do
          assert_select 'tbody td', text: resource.description
        end
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
