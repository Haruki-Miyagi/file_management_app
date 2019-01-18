require 'rails_helper'

RSpec.describe FoldersController, type: :controller do
  let(:admin_user) { create(:user, :admin) }
  let!(:root) { create(:folder, name: 'Root', description: 'Root Folder', user_id: admin_user.id) }

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

  describe 'GET #index' do
    let!(:folder01) { create(:folder, parent_id: root.id) }
    let!(:folder02) { create(:folder, parent_id: root.id) }

    def do_render
      get :index
    end

    context 'サインインしている時' do
      before do
        sign_in(admin_user)
        do_render
      end

      it 'returns http success' do
        expect(response).to have_http_status(:success)
      end

      it 'assigns @resource' do
        expect(assigns(:resource)).to eq(root)
      end

      it 'assigns @resources' do
        expect(assigns(:resources)).to eq([folder02, folder01])
      end

      it 'renders the :index template' do
        expect(response).to render_template :index
      end
    end

    include_examples 'サインインしていない時'
  end

  describe 'GET #show' do
    let(:resource) { create(:folder, parent_id: root.id) }
    let!(:folder01) { create(:folder, parent_id: resource.id) }
    let!(:folder02) { create(:folder, parent_id: resource.id) }

    def do_render
      get :show, params: { id: resource.id }
    end

    context 'サインインしている時' do
      before do
        sign_in(admin_user)
        do_render
      end

      it 'returns http success' do
        expect(response).to have_http_status(:success)
      end

      it 'assigns @resources' do
        expect(assigns(:resources)).to eq([folder02, folder01])
      end

      it 'assigns @root_below_folder' do
        expect(assigns(:root_below_folder)).to eq([resource])
      end

      it 'renders the :show template' do
        expect(response).to render_template :show
      end
    end

    include_examples 'サインインしていない時'
  end

  describe 'GET #new' do
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
    let(:resource) { create(:folder, parent_id: root.id) }

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
    let(:name) { 'name' }
    let(:description) { 'description' }
    let(:ancestry) { 1 }
    let(:parent_id) { root.id }
    let(:user_id) { admin_user }
    let(:valid_attributes) do
      {
        name: name,
        description: description,
        ancestry: ancestry,
        parent_id: parent_id,
        user_id: user_id
      }
    end

    def do_render
      post :create, params: { folder: valid_attributes }
    end

    context 'サインインしている時' do
      context 'with valid params' do
        before { sign_in(admin_user) }

        it 'creates a new Folder' do
          expect do
            do_render
          end.to change(Folder, :count).by(1)
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
    let(:resource) { create(:folder, parent_id: root.id) }
    let(:name) { 'folder_name' }
    let(:description) { 'folder_description' }
    let(:ancestry) { 1 }
    let(:parent_id) { root.id }
    let(:user_id) { admin_user }
    let(:new_attributes) do
      {
        name: name,
        description: description,
        ancestry: ancestry,
        parent_id: parent_id,
        user_id: user_id
      }
    end

    def do_render
      patch :update, params: { id: resource.to_param, folder: new_attributes }
    end

    context 'サインインしている時' do
      context 'with valid params' do
        before { sign_in(admin_user) }

        it 'saves updated folder' do
          expect do
            do_render
          end.to change(Folder, :count).by(1)
        end

        it 'redirects to the folders#index' do
          do_render
          expect(response).to redirect_to(folders_path)
        end

        it 'updates updated folder' do
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
    let!(:resource) { create(:folder, parent_id: root.id) }

    def do_render
      delete :destroy, params: { id: resource.id }
    end

    context 'サインインしている時' do
      before do
        sign_in(admin_user)
      end

      it 'deletes the folders' do
        expect do
          do_render
        end.to change(Folder, :count).by(-1)
      end

      it 'redirects the :create template' do
        do_render
        expect(response).to redirect_to(folders_path)
      end
    end

    include_examples 'サインインしていない時'
  end
end
