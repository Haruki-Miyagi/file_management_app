require 'rails_helper'

RSpec.describe 'folders/index.html.erb', type: :view do
  let(:root) { create(:folder, name: 'Root', description: 'Root Folder') }
  let!(:resources) { create_list(:folder, 2, parent_id: root.id) }

  before do
    assign(:resources, resources)
    render
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
end
