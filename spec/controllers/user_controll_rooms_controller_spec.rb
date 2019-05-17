require 'rails_helper'

RSpec.describe UserControllRoomsController, type: :controller do
  let(:admin_user) { create(:user, :admin) }
  let(:root) { create(:folder, name: 'Root', description: 'Root Folder', user_id: admin_user.id) }
  let(:room) { create(:room, user_id: admin_user.id, folder_id: root.id) }

  shared_examples 'サインインしていない時' do
    context 'サインインしていない時' do
      before do
        do_render
      end

      it 'returns http 302' do
        expect(response).to have_http_status('302')
      end

      it 'ログイン画面へリダイレクトすること' do
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe 'POST #create' do
    let(:room_id) { room.id }

    def do_render
      post :create, params: { user_controll_room: {}, room_id: room.id }
    end

    context 'サインインしている時' do
      context 'with valid params' do
        before do
          allow(controller).to receive(:current_user).and_return(admin_user)
          sign_in(admin_user)
        end

        it 'creates a new UserControllRoom' do
          expect do
            do_render
          end.to change(UserControllRoom, :count).by(1)
        end

        it 'redirects to the created folders#index' do
          do_render
          expect(response).to redirect_to(folders_path)
        end

        it 'flash[:notice]にメッセージが含まれること' do
          do_render
          expect(flash[:notice]).to eq('お気に入りに登録しました。')
        end
      end
    end

    include_examples 'サインインしていない時'
  end

  describe 'DELETE #destroy' do
    let!(:user_controll_room) { create(:user_controll_room) }

    def do_render
      delete :destroy, params: { id: user_controll_room }
    end

    context 'サインインしている時' do
      before do
        sign_in(admin_user)
      end

      it 'deletes the user_controll_room' do
        expect do
          do_render
        end.to change(UserControllRoom, :count).by(-1)
      end

      it 'redirects the :create template' do
        do_render
        expect(response).to redirect_to(folders_path)
      end
    end
  end
end
