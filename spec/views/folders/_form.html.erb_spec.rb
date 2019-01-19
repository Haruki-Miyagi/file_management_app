require 'rails_helper'

RSpec.describe 'folders/_form.html.erb', type: :view do
  let(:user) { create(:user, :admin) }
  let(:root) { create(:folder, name: 'Root', description: 'Root Folder') }
  let(:folder) { create(:folder, parent_id: root.id) }

  before do
    allow(view).to receive(:current_user).and_return(user)
    render partial: 'folders/form', locals: { resource: folder }
  end

  it '閉じるボタンがあること' do
    assert_select 'button.close[type="button"]' do
      assert_select 'span', text: '×'
    end
  end

  it 'Root内フォルダのヘッダーがあること' do
    assert_select 'h4.modal-title', text: "#{folder.name}フォルダ"
  end

  it 'フォームを表示すること' do
    assert_select 'form[action=?][method="post"]', "/folders/#{folder.id}" do
      assert_select 'input[type=hidden][value=?]#folder_parent_id', root.id.to_s
      assert_select 'input[type=hidden][value=?]#folder_user_id', user.id.to_s
      assert_select 'input[type="submit"]'
    end
  end

  it 'フォルダ名入力欄を表示すること' do
    assert_select 'label[for="folder_name"]', text: 'フォルダ名'
    assert_select 'input.form-control[type="text"][name=?]', 'folder[name]'
  end

  it '備考入力欄を表示すること' do
    assert_select 'label[for="folder_description"]', text: '備考'
    assert_select 'textarea.form-control[name=?]', 'folder[description]'
  end
end
