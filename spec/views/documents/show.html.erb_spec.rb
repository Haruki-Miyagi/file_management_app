require 'rails_helper'

RSpec.describe 'documents/show.html.erb', type: :view do
  let(:admin_user) { create(:user, :admin) }
  let(:root) { create(:folder, name: 'Root', description: 'Root Folder', user_id: admin_user.id) }
  let(:room) { create(:room, user_id: admin_user.id, folder_id: root.id) }
  let(:resource) { create(:document, user_id: admin_user.id, room_id: room.id, uploaded_file: uploaded_file) }
  let(:uploaded_file) do
    Rack::Test::UploadedFile.new(
      Rails.root.join('spec', 'up_folder', 'file01.xlsx'), 'application/vnd.ms-excel'
    )
  end

  before do
    allow(view).to receive(:current_user).and_return(admin_user)
    assign(:resource, resource)
    assign(:room, room)
    render
  end

  it 'ファイル詳細名が表示されていること' do
    assert_select 'h2', text: "#{resource.file_name}ファイルの詳細"
  end

  it 'ファイル管理一覧へのリンクがあること' do
    assert_select 'h3 a[href=?]', room_path(room).to_s, text: 'ファイル管理一覧' do
      assert_select 'i.glyphicon.glyphicon-menu-left'
    end
  end

  context '(.jpg, .jpeg, .png, gif)以外の拡張子の場合' do
    it 'プレビューは表示されません。のテキスト文があること' do
      assert_select 'div.thumbnail p', text: 'プレビューは表示されません。'
    end
  end

  context '(.jpg, .jpeg, .png, gif)の拡張子の場合' do
    let(:uploaded_file) do
      Rack::Test::UploadedFile.new(
        Rails.root.join('spec', 'up_folder', 'pdffile01.png'), 'image/png'
      )
    end

    it 'プレビュー画像が表示されていること' do
      assert_select 'img[src=?]', "/uploads/document/uploaded_file/#{resource.id}/#{uploaded_file.original_filename}"
    end
  end

  it '備考欄のテキストがあること' do
    assert_select 'h4', text: '備考欄'
  end

  it '備考があること' do
    assert_select 'div.caption' do
      assert_select 'p', text: resource.description.to_s
    end
  end

  context '編集' do
    it 'リンク付きの編集アイコンがあること' do
      assert_select 'div.caption' do
        assert_select 'p a[href=?]', edit_room_document_path(room, resource) do
          assert_select 'i[class=?]', 'glyphicon glyphicon-edit'
        end
      end
    end

    it 'ポップアップメッセージがあること' do
      assert_select 'div.caption' do
        assert_select 'a[title=?]', '編集するにはクリックしてください'
        assert_select 'a[data-toggle=?]', 'tooltip'
      end
    end
  end

  it 'リンク付きの削除アイコンがあること' do
    assert_select 'div.caption' do
      assert_select 'p a[href=?][data-method="delete"]', room_document_path(room, resource) do
        assert_select 'i[class=?]', 'glyphicon glyphicon-trash'
      end
    end
  end
end
