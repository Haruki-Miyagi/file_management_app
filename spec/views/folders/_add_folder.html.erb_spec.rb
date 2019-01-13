require 'rails_helper'

RSpec.describe 'folders/index.html.erb', type: :view do
  let(:root) { create(:folder, name: 'Root', description: 'Root Folder') }
  let!(:resources) { create_list(:folder, 2, parent_id: root.id) }

  before do
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
        it '新しくフォルダを作成しますのテキストがあること' do
          assert_select 'ul.table-add-list li' do
            assert_select 'a[title=?]', '新しくフォルダを作成します'
            assert_select 'a[data-toggle=?]', 'tooltip'
          end
        end

        it 'スクリプトがあること' do
          assert_select 'script', /data-toggle/
          assert_select 'script', /tooltip/
        end

        it 'pcとモバイルで表示法をわけてあること' do
          assert_select 'script', /navigator.userAgent/
        end
      end
    end
  end
end
