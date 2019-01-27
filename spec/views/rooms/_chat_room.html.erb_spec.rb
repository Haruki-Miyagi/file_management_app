require 'rails_helper'

RSpec.describe 'rooms/_chat_room.html.erb', type: :view do
  let(:user) { create(:user, :admin) }
  let(:root) { create(:folder, name: 'Root', description: 'Root Folder') }
  let(:resource) { create(:room, user_id: user.id, folder_id: root.id) }
  let(:messages) { create_list(:message, 3, user_id: user.id, room_id: resource.id) }

  before do
    render partial: 'rooms/chat_room', locals: { resource: resource, messages: messages }
  end

  context 'チャットフォーム' do
    context 'ヘッダー' do
      it 'チャットルーム名があること' do
        assert_select 'div.chat_form' do
          assert_select 'div.panel-heading h3.panel-title', text: "ファイル管理名 : #{resource.name}"
        end
      end
    end

    context 'チャットボディ' do
      it 'メールアドレスがあること' do
        assert_select 'div.chat_form' do
          assert_select 'div.panel-body[data-room_id=?]#messages', resource.id.to_s do
            assert_select 'div.message div.col-md-4:nth-child(1)', user.email.to_s
          end
        end
      end

      it 'メッセージがあること' do
        assert_select 'div.chat_form' do
          assert_select 'div.panel-body[data-room_id=?]#messages', resource.id.to_s do
            assert_select 'div.message div.bms_message_content:nth-child(1)', messages.first.content.to_s
          end
        end
      end
    end

    context 'フォーム' do
      it 'テキストボックスがあること' do
        assert_select 'form.form-group' do
          assert_select 'div.col-sm-11' do
            assert_select 'textarea.form-control[type="text"][placeholder="テキストを入力してください。"]'
          end
        end
      end

      it '送信ボタンがあること' do
        assert_select 'form.form-group' do
          assert_select 'div.col-sm-1' do
            assert_select 'button[type="button"]', text: '送信'
          end
        end
      end

      it 'pc用のコメントメッセージがあること' do
        assert_select 'form.form-group' do
          assert_select 'div.col-sm-12 p', text: 'PCの場合は入力後Control + enter キーでも送信できます。'
        end
      end
    end
  end
end
