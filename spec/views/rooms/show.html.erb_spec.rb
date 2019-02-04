require 'rails_helper'

RSpec.describe 'rooms/show.html.erb', type: :view do
  let(:admin_user) { create(:user, :admin) }
  let(:root) { create(:folder, name: 'Root', description: 'Root Folder', user_id: admin_user.id) }
  let(:resource) { create(:room, user_id: admin_user.id, folder_id: root.id) }
  let(:messages) { create_list(:message, 3, user_id: admin_user.id, room_id: resource.id) }
  let(:documents) { create_list(:document, 3, user_id: admin_user.id, room_id: resource.id) }

  before do
    allow(view).to receive(:current_user).and_return(admin_user)
    assign(:resource, resource)
    assign(:messages, messages)
    assign(:documents, documents)
    render
  end

  context 'チャットパネル' do
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
          assert_select 'div.panel-body[data-room_id=?]', resource.id.to_s do
            assert_select 'div.col-md-4:nth-child(1)', admin_user.email.to_s
          end
        end
      end

      it 'メッセージがあること' do
        assert_select 'div.chat_form' do
          assert_select 'div.panel-body[data-room_id=?]', resource.id.to_s do
            assert_select 'div.bms_message_content:nth-child(1)', messages.first.content.to_s
          end
        end
      end
    end

    context 'フォーム' do
      it 'テキストボックスがあること' do
        assert_select 'form.form-group' do
          assert_select 'div.col-sm-11' do
            assert_select 'textarea[type="text"].form-control'
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

  context '追加ボタン' do
    context 'ファイル' do
      context 'ファイル追加ボタン' do
        it 'リンク付きであること' do
          assert_select 'ul.table-add-list li' do
            assert_select 'a[href=?]', "/rooms/#{resource.id}/documents/new"
            assert_select 'a', text: '+'
            assert_select 'i[class=?]', 'glyphicon glyphicon-copy'
          end
        end

        it '新しくファイルを作成しますのポップアップメッセージがあること' do
          assert_select 'ul.table-add-list li' do
            assert_select 'a[title=?]', '新しくファイルを作成します'
            assert_select 'a[data-toggle=?]', 'tooltip'
          end
        end
      end
    end
  end

  it 'パネルタイトルがあること' do
    assert_select 'div.panel-heading' do
      assert_select 'h3.panel-title', text: "ファイル管理名 : #{resource.name}"
    end
  end

  it 'パネル内にメールアドレスがあること' do
    assert_select 'div.panel-body.pre-scrollable.scroll-bar' do
      assert_select 'div.col-md-4', text: messages.first.user.email.to_s
    end
  end

  it 'パネル内にメッセージ内容があること' do
    assert_select 'div.panel-body.pre-scrollable.scroll-bar' do
      assert_select 'div.bms_message_content p', text: messages.first.content.to_s
    end
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
        assert_select 'thead th.text-center', text: '編集', count: 1
      end
    end

    it '削除があること' do
      assert_select 'table.table' do
        assert_select 'thead th.text-center', text: '削除', count: 1
      end
    end
  end

  context 'テーブル本体' do
    it 'リンク付きのファイルのテキストがあること' do
      documents.each do |document|
        assert_select 'table.table' do
          assert_select 'tbody td', text: document.file_name
        end
      end
    end

    it '備考のテキストがあること' do
      documents.each do |document|
        assert_select 'table.table' do
          assert_select 'tbody td', text: document.description
        end
      end
    end

    context '編集' do
      it 'リンク付きの編集アイコンがあること' do
        documents.each do |document|
          assert_select 'table.table' do
            assert_select 'tbody td a[href=?]', edit_room_document_path(resource, document) do
              assert_select 'i[class=?]', 'glyphicon glyphicon-edit'
            end
          end
        end
      end

      it 'ポップアップメッセージがあること' do
        assert_select 'table.table td' do
          assert_select 'a[title=?]', '編集するにはクリックしてください'
          assert_select 'a[data-toggle=?]', 'tooltip'
        end
      end
    end

    it 'リンク付きの削除アイコンがあること' do
      documents.each do |document|
        assert_select 'table.table' do
          assert_select 'tbody td a[href=?][data-method="delete"]', room_document_path(resource, document) do
            assert_select 'i[class=?]', 'glyphicon glyphicon-trash'
          end
        end
      end
    end
  end
end
