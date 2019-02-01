require 'rails_helper'

RSpec.describe 'documents/_form.html.erb', type: :view do
  let(:user) { create(:user, :admin) }
  let(:root) { create(:folder, name: 'Root', description: 'Root Folder') }
  let(:room) { create(:room, user_id: user.id, folder_id: root.id) }
  let(:document) { Document.new }

  before do
    allow(view).to receive(:current_user).and_return(user)
    render partial: 'documents/form', locals: { resource: document, room: room }
  end

  it '閉じるボタンがあること' do
    assert_select 'button.close[type="button"]' do
      assert_select 'span', text: '×'
    end
  end

  it 'ヘッダーがあること' do
    assert_select 'h4.modal-title', text: 'ファイル追加'
  end

  it 'フォームを表示すること' do
    assert_select 'form[action=?][method="post"]', "/rooms/#{room.id}/documents" do
      assert_select 'input[type=hidden][value=?]#document_user_id', user.id.to_s
      assert_select 'input[type=hidden][value=?]#document_room_id', room.id.to_s
      assert_select 'input[type="submit"]'
    end
  end

  it 'ファイル名入力テキストボックスがあること' do
    assert_select 'label[for="document_file_name"]', text: 'ファイル名(保存用のファイル名)'
    assert_select 'input.form-control[type="text"][name=?]', 'document[file_name]'
  end

  it 'ファイル追加欄があること' do
    assert_select 'label[for="document_file_date"]', text: 'ファイル'
    assert_select 'input[type="file"][name=?]', 'document[file_date]'
  end

  context 'ファイル更新のとき' do
    let!(:document) { create(:document) }

    it '保存してあるファイル名が表示されること' do
      assert_select 'div.form-group p', text: "保存ファイル：#{document[:uploaded_file]}"
    end
  end

  it '備考入力欄があること' do
    assert_select 'label[for="document_description"]', text: '備考'
    assert_select 'textarea.form-control[name=?]', 'document[description]'
  end

  it 'サブミットボタンがあること' do
    assert_select 'input.form-control[type="submit"]'
  end
end
