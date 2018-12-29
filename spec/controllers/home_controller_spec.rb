require 'rails_helper'

RSpec.describe HomeController, type: :controller do
  describe 'GET #index' do
    let(:user) { create(:user) }
    def do_render
      get :index
    end

    context 'サインインしている時' do
      before { sign_in(user) }

      it 'returns http success' do
        do_render
        expect(response).to have_http_status(:success)
      end
    end

    context 'サインインしていない時' do
      it 'returns http 302' do
        do_render
        expect(response).to have_http_status('302')
      end

      it 'ログイン画面へリダイレクトすること' do
        do_render
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end
