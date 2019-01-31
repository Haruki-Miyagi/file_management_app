require 'rails_helper'

RSpec.describe DocumentsController, type: :controller do
  let(:admin_user) { create(:user, :admin) }
  let(:root) { create(:folder, name: 'Root', description: 'Root Folder', user_id: admin_user.id) }
  let(:resource) { create(:room, user_id: admin_user.id, folder_id: root.id) }

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

  describe 'GET #new' do
    def do_render
      get :new, params: { room_id: resource.id }
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
    let(:document) { create(:document) }

    def do_render
      get :edit, params: { room_id: resource.id, id: document.id }
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
    let(:file_name) { 'Document-Name' }
    let(:file_date) do
      Rack::Test::UploadedFile.new(
        Rails.root.join('spec', 'up_folder', 'file01.xlsx'), 'application/vnd.ms-excel'
      )
    end
    let(:description) { 'Document-Description' }
    let(:user_id) { admin_user.id }
    let(:room_id) { resource.id }
    let(:valid_attributes) do
      {
        file_name: file_name,
        file_date: file_date,
        description: description,
        user_id: user_id,
        room_id: room_id
      }
    end

    def do_render
      post :create, params: { room_id: resource.id, document: valid_attributes }
    end

    context 'サインインしている時' do
      context 'with valid params' do
        before { sign_in(admin_user) }

        it 'creates a new Document' do
          expect do
            do_render
          end.to change(Document, :count).by(1)
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
        let(:file_name) { '' }

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
    let(:document) { create(:document) }
    let(:file_name) { 'Document-Chenged-Name' }
    let(:file_date) do
      Rack::Test::UploadedFile.new(
        Rails.root.join('spec', 'up_folder', 'file01.xlsx'), 'application/vnd.ms-excel'
      )
    end
    let(:description) { 'Document-Chenged-Description' }
    let(:user_id) { admin_user.id }
    let(:room_id) { resource.id }
    let(:new_attributes) do
      {
        file_name: file_name,
        file_date: file_date,
        description: description,
        user_id: user_id,
        room_id: room_id
      }
    end

    let(:document) { create(:document) }

    def do_render
      patch :update, params: { room_id: resource.id, id: document.id, document: new_attributes }
    end

    context 'サインインしている時' do
      context 'with valid params' do
        before { sign_in(admin_user) }

        it 'saves updated document' do
          expect do
            do_render
          end.to change(Document, :count).by(1)
        end

        it 'redirects to the folders#index' do
          do_render
          expect(response).to redirect_to(folders_path)
        end

        it 'updates updated document' do
          do_render
          document.reload
          expect(document.file_name).to eq('Document-Chenged-Name.xlsx')
          expect(document.description).to eq(description)
        end

        it 'flash[:notice]にメッセージが含まれること' do
          do_render
          expect(flash[:notice]).to eq('正常に更新しました。')
        end
      end
    end

    include_examples 'サインインしていない時'
  end

  describe 'DELETE #destroy' do
    let!(:document) { create(:document) }

    def do_render
      delete :destroy, params: { room_id: resource.id, id: document.id }
    end

    context 'サインインしている時' do
      before do
        sign_in(admin_user)
      end

      it 'deletes the document' do
        expect do
          do_render
        end.to change(Document, :count).by(-1)
      end

      it 'redirects to folders#index' do
        do_render
        expect(response).to redirect_to(folders_path)
      end
    end

    include_examples 'サインインしていない時'
  end
end
