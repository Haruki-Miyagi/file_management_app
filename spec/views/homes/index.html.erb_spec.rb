require 'rails_helper'

RSpec.describe 'homes/index.html.erb', type: :view do
  let(:user) { create(:user, :admin) }
  let(:rooms) { create_list(:room, 5, user_id: user.id) }

  before do
    allow(view).to receive(:current_user).and_return(user)
    assign(:resources, rooms)
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
    it 'リンク付きのファイルのテキストがある表示してあること' do
      rooms.each do |resource|
        assert_select 'table.table' do
          assert_select 'tbody td a', text: resource.name
        end
      end
    end

    it '備考のテキストがある表示してあること' do
      rooms.each do |resource|
        assert_select 'table.table' do
          assert_select 'tbody td', text: resource.description
        end
      end
    end

    context '編集' do
      it 'リンク付きの編集アイコンがあること' do
        assert_select 'table.table' do
          assert_select 'tbody td a' do
            assert_select 'i[class=?]', 'glyphicon glyphicon-edit'
          end
        end
      end
    end

    it 'リンク付きの削除アイコンがあること' do
      assert_select 'table.table' do
        assert_select 'tbody td a[data-method="delete"]' do
          assert_select 'i[class=?]', 'glyphicon glyphicon-trash'
        end
      end
    end
  end
end
