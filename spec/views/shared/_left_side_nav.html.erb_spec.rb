require 'rails_helper'

RSpec.describe 'shared/_left_side_nav', type: :view do
  before do
    render partial: 'shared/left_side_nav'
  end

  it 'Homeのリンクがあること' do
    assert_select 'nav#l-side-main-menu ul li' do
      assert_select 'a[href=?]', root_path, text: 'Home'
    end
  end
end
