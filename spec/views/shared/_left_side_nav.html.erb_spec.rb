require 'rails_helper'

RSpec.describe 'shared/_left_side_nav', type: :view do
  before do
    render partial: 'shared/left_side_nav'
  end

  it 'フォルダ管理画面へのリンクがあること' do
    assert_select 'nav#l-side-main-menu ul li' do
      assert_select 'a[href=?]', folders_path, text: 'フォルダ管理'
    end
  end
end
