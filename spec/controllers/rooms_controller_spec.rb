require 'rails_helper'

RSpec.describe RoomsController, type: :controller do
  let(:admin_user) { create(:user, :admin) }
  let(:root) { create(:folder, name: 'Root', description: 'Root Folder', user_id: admin_user.id) }
  let(:folder) { create(:folder, parent_id: root.id) }

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

  describe 'GET #show' do
    let(:resource) { create(:room, user_id: admin_user.id, folder_id: root.id) }
    let(:messages) { create_list(:message, 3, room_id: resource.id) }
    let(:documents) { create_list(:document, 3, user_id: admin_user.id, room_id: resource.id) }
    let!(:user_controll_room) { create(:user_controll_room, user_id: admin_user.id, room_id: resource.id) }

    def do_render
      get :show, params: { id: resource.id }
    end

    context 'サインインしている時' do
      before do
        allow(controller).to receive(:current_user).and_return(admin_user)
        sign_in(admin_user)
        do_render
      end

      it 'returns http success' do
        expect(response).to have_http_status(:success)
      end

      it 'assigns @resource' do
        expect(assigns(:resource)).to eq(resource)
      end

      it 'assigns @messages' do
        expect(assigns(:messages)).to eq(messages)
      end

      it 'assigns @documents' do
        expected_value = documents.reverse
        expect(assigns(:documents)).to eq(expected_value)
      end

      it 'assigns @user_controll_room' do
        expect(assigns(:user_controll_room)).to eq(user_controll_room)
      end

      it 'renders the :show template' do
        expect(response).to render_template :show
      end
    end

    include_examples 'サインインしていない時'
  end

  describe 'GET #new' do
    let(:resource) { create(:room, user_id: admin_user.id, folder_id: root.id) }

    def do_render
      get :new, params: {}
    end

    context 'サインインしている時' do
      before do
        sign_in(admin_user)
        do_render
      end

      pending 'get :new, params: {}, format: :js'
    end

    include_examples 'サインインしていない時'
  end

  describe 'GET #edit' do
    let(:resource) { create(:room, user_id: admin_user.id, folder_id: root.id) }

    def do_render
      get :edit, params: { id: resource.to_param }
    end

    context 'サインインしている時' do
      before do
        sign_in(admin_user)
        do_render
      end

      pending 'get :edit, params: { id: resource.to_param } => format: :js'
    end

    include_examples 'サインインしていない時'
  end

  describe 'POST #create' do
    let(:name) { 'Room-Name' }
    let(:description) { 'Room-Description' }
    let(:folder_id) { root.id }
    let(:user_id) { admin_user.id }
    let(:valid_attributes) do
      {
        name: name,
        description: description,
        folder_id: folder_id,
        user_id: user_id
      }
    end

    def do_render
      post :create, params: { room: valid_attributes }
    end

    context 'サインインしている時' do
      context 'with valid params' do
        before { sign_in(admin_user) }

        it 'creates a new Room' do
          expect do
            do_render
          end.to change(Room, :count).by(1)
        end

        it 'redirects to the created folders#index' do
          do_render
          expect(response).to redirect_to(folders_path)
        end

        it 'flash[:notice]にメッセージが含まれること' do
          do_render
          expect(flash[:notice]).to eq('新しく作成しました。')
        end
      end

      context 'with invalid params' do
        let(:name) { '' }

        before do
          sign_in(admin_user)
          do_render
        end

        pending 'get :new, params: {}, format: :js'
      end
    end

    include_examples 'サインインしていない時'
  end

  describe 'PATCH #update' do
    let(:resource) { create(:room, user_id: admin_user.id, folder_id: root.id) }
    let(:name) { 'Room-Change-Name' }
    let(:description) { 'Room-Change-Description' }
    let(:folder_id) { root.id }
    let(:user_id) { admin_user.id }

    let(:new_attributes) do
      {
        name: name,
        description: description,
        folder_id: folder_id,
        user_id: user_id
      }
    end

    def do_render
      patch :update, params: { id: resource.to_param, room: new_attributes }
    end

    context 'サインインしている時' do
      context 'with valid params' do
        before { sign_in(admin_user) }

        it 'saves updated room' do
          expect do
            do_render
          end.to change(Room, :count).by(1)
        end

        it 'redirects to the folders#index' do
          do_render
          expect(response).to redirect_to(folders_path)
        end

        it 'updates updated room' do
          do_render
          resource.reload
          expect(resource.name).to eq(name)
          expect(resource.description).to eq(description)
        end

        it 'flash[:notice]にメッセージが含まれること' do
          do_render
          expect(flash[:notice]).to eq('正常に更新しました。')
        end
      end

      context 'with invalid params' do
        let(:name) { '' }

        before do
          sign_in(admin_user)
          do_render
        end

        pending 'get :edit, params: { id: resource.to_param } => format: :js'
      end
    end

    include_examples 'サインインしていない時'
  end

  describe 'DELETE #destroy' do
    let!(:resource) { create(:room, user_id: admin_user.id, folder_id: root.id) }

    def do_render
      delete :destroy, params: { id: resource.id }
    end

    context 'サインインしている時' do
      before do
        sign_in(admin_user)
      end

      it 'deletes the rooms' do
        expect do
          do_render
        end.to change(Room, :count).by(-1)
      end

      it 'redirects to folders#index' do
        do_render
        expect(response).to redirect_to(folders_path)
      end
    end

    include_examples 'サインインしていない時'
  end
end
