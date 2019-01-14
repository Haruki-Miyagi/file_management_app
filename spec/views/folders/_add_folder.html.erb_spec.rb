require 'rails_helper'

RSpec.describe 'folders/_add_folder.html.erb', type: :view do
  let(:root) { create(:folder, name: 'Root', description: 'Root Folder') }
  let!(:resources) { create_list(:folder, 2, parent_id: root.id) }

  before do
    render partial: 'folders/add_folder', locals: { resource: root }
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

      it '新しくフォルダを作成しますのポップアップメッセージがあること' do
        assert_select 'ul.table-add-list li' do
          assert_select 'a[title=?]', '新しくフォルダを作成します'
          assert_select 'a[data-toggle=?]', 'tooltip'
        end
      end
    end
  end
end
