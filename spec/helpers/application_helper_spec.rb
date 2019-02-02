require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  describe '#resource_error_messages!' do
    context 'ユーザーフォーム(devise)' do
      let(:resource) { create(:user) }

      context 'エラーメッセージがある時' do
        context 'テキスト入力で空入力の場合' do
          it 'xx が記入されていません。のエラーメッセージがあること' do
            resource.update(email: '', password: '')
            expect(resource_error_messages!(resource)).to include('メールアドレス が記入されていません。')
            expect(resource_error_messages!(resource)).to include('パスワード が記入されていません。')
          end
        end

        context 'メールフォーマットが不正な場合' do
          it 'メールアドレス が不正な値です。のエラーメッセージがあること' do
            resource.update(email: 'abc@')
            expect(resource_error_messages!(resource)).to include('メールアドレス が不正な値です。')
          end
        end

        context 'パスワードが5文字以内の場合' do
          it 'パスワード は6文字以上で記入してください。のエラーメッセージがあること' do
            text = 'a' * 5
            resource.update(password: text)
            expect(resource_error_messages!(resource)).to include('パスワード は6文字以上で記入してください。')
          end
        end
      end

      context 'エラーメッセージが空のとき' do
        it 'エラーメッセージがないこと' do
          expect(resource_error_messages!(resource)).to be_blank
        end
      end
    end

    context 'フォルダフォーム' do
      let(:resource) { create(:folder) }

      context 'エラーメッセージがある時' do
        context 'フォルダ名が空入力の場合' do
          it 'フォルダ名 が記入されていません。のエラーメッセージがあること' do
            resource.update(name: '')
            expect(resource_error_messages!(resource)).to include('フォルダ名 が記入されていません。')
          end
        end
      end

      context 'エラーメッセージが空のとき' do
        it 'エラーメッセージがないこと' do
          expect(resource_error_messages!(resource)).to be_blank
        end
      end
    end
  end

  describe 'edit_permission_exist?' do
    let(:others_user) { create(:user) }
    let(:admin_user) { create(:user, :admin) }
    let(:others_folder) { create(:folder, user_id: others_user.id) }
    let(:admin_folder) { create(:folder, user_id: admin_user.id) }

    context 'ユーザーがadmin_userの場合' do
      before { allow(helper).to receive(:current_user).and_return(admin_user) }

      it 'trueを返すこと' do
        expect(helper.edit_permission_exist?(others_folder)).to eq(true)
        expect(helper.edit_permission_exist?(admin_folder)).to eq(true)
      end
    end

    context 'ユーザーがothers_userの場合' do
      before { allow(helper).to receive(:current_user).and_return(others_user) }

      context '権限がある時' do
        it 'trueを返すこと' do
          expect(helper.edit_permission_exist?(others_folder)).to eq(true)
        end
      end

      context '権限がないとき' do
        it 'falseを返すこと' do
          expect(helper.edit_permission_exist?(admin_folder)).to eq(false)
        end
      end
    end
  end
end
