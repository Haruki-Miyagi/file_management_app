require 'rails_helper'

RSpec.describe DeviseHelper, type: :helper do
  describe '#devise_error_messages?' do
    let(:resource) { create(:user) }

    context 'エラーメッセージがある時' do
      context '空入力の場合' do
        it 'エラーメッセージがあること' do
          resource.update(email: '', password: '')
          expect(devise_error_messages!).to include('Email can&#39;t be blank')
          expect(devise_error_messages!).to include('Password can&#39;t be blank')
        end
      end

      context 'メールフォーマットが不正な場合' do
        it 'エラーメッセージがあること' do
          resource.update(email: 'abc@')
          expect(devise_error_messages!).to include('Email is invalid')
        end
      end

      context '5文字以内の場合' do
        it 'エラーメッセージがあること' do
          text = 'a' * 5
          resource.update(password: text)
          expect(devise_error_messages!).to include('Password is too short (minimum is 6 characters)')
        end
      end
    end

    context 'エラーメッセージが空のとき' do
      it 'エラーメッセージがないこと' do
        expect(devise_error_messages!).to be_blank
      end
    end
  end
end
