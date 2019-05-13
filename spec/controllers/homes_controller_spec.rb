require 'rails_helper'

RSpec.describe HomesController, type: :controller do
  describe 'GET #index' do
    let(:user) { create(:user, :admin) }
    let(:room) { create(:room, user_id: user.id, folder_id: root.id) }
    let!(:user_controll_rooms) { create_list(:user_controll_room, 5, user_id: user.id) }

    def do_render
      get :index
    end

    context 'サインインしている時' do
      before { sign_in(user) }

      it 'returns http success' do
        do_render
        expect(response).to have_http_status(:success)
      end

      it 'assigns @resource' do
        do_render
        expect(assigns(:resources)).to eq(user.pending_rooms)
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
