require 'rails_helper'

RSpec.describe FoldersController, type: :controller do
  let(:user) { create(:user) }
  let!(:root) { create(:folder, name: 'Root', description: 'Root Folder') }

  shared_examples 'サインインしていない時' do
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

  describe 'GET #index' do
    def do_render
      get :index
    end

    context 'サインインしている時' do
      before { sign_in(user) }

      it 'returns http success' do
        do_render
        expect(response).to have_http_status(:success)
      end

      it 'assigns @folder' do
        do_render
        expect(assigns(:folder)).to eq(root)
      end

      it 'renders the :index template' do
        do_render
        expect(response).to render_template :index
      end
    end

    include_examples 'サインインしていない時'
  end

  describe 'GET #show' do
    let(:folder) { create(:folder, parent_id: root.id) }

    def do_render
      get :show, params: { id: folder.id }
    end

    context 'サインインしている時' do
      before { sign_in(user) }

      it 'returns http success' do
        expect(response).to have_http_status(:success)
      end

      it 'assigns @folder' do
        do_render
        expect(assigns(:folder)).to eq(folder)
      end

      it 'renders the :show template' do
        do_render
        expect(response).to render_template :show
      end
    end

    include_examples 'サインインしていない時'
  end
end
