require 'rails_helper'

RSpec.describe 'folders/_folder_table.html.erb', type: :view do
  let(:message) { create(:message) }

  before do
    assign(:message, message)
    render partial: 'messages/message', locals: { message: message }
  end

  it 'メールアドレスがあること' do
    assert_select 'div.col-md-4', text: message.user.email.to_s
  end

  it 'メッセージ内容があること' do
    assert_select 'div.col-md-8 p', text: message.content.to_s
  end
end
