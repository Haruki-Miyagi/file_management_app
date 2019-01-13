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
end
