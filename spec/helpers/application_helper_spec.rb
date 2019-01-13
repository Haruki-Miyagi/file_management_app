require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  describe '#resource_error_messages!' do
    let(:resource) { create(:folder) }

    before do
      @resource = resource
    end

    context 'エラーメッセージがある時' do
      context '空入力の場合' do
        it 'エラーメッセージがあること' do
          resource.update(name: '')
          expect(resource_error_messages!).to include('フォルダ名 が記入されていません。')
        end
      end
    end

    context 'エラーメッセージが空のとき' do
      it 'エラーメッセージがないこと' do
        expect(resource_error_messages!).to be_blank
      end
    end
  end
end
