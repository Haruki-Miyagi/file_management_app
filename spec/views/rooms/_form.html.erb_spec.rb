require 'rails_helper'

RSpec.describe 'room/_form.html.erb', type: :view do
  let(:user) { create(:user, :admin) }
  let(:root) { create(:folder, name: 'Root', description: 'Root Folder') }
  let(:room) { create(:room, user_id: user.id, folder_id: root.id) }

  before do
    allow(view).to receive(:current_user).and_return(user)
    render partial: 'rooms/form', locals: { resource: room }
  end

  it '閉じるボタンがあること' do
    assert_select 'button.close[type="button"]' do
      assert_select 'span', text: '×'
    end
  end

  it 'Root内ファイル管理のヘッダーがあること' do
    assert_select 'h4.modal-title', text: "#{room.name}ファイル管理"
  end

  it 'フォームを表示すること' do
    assert_select 'form[action=?][method="post"]', "/rooms/#{room.id}" do
      assert_select 'input[type=hidden][value=?]#room_folder_id', root.id.to_s
      assert_select 'input[type=hidden][value=?]#room_user_id', user.id.to_s
      assert_select 'input[type="submit"]'
    end
  end

  it 'ファイル管理名入力欄を表示すること' do
    assert_select 'label[for="room_name"]', text: 'ファイル管理名'
    assert_select 'input.form-control[type="text"][name=?]', 'room[name]'
  end

  it '備考入力欄を表示すること' do
    assert_select 'label[for="room_description"]', text: '備考'
    assert_select 'textarea.form-control[name=?]', 'room[description]'
  end
end
