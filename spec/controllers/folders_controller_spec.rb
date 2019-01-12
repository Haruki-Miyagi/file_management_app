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

      it 'assigns @root_folder' do
        expect(assigns(:root_folder)).to eq(root)
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

      it 'renders the :show template' do
        expect(response).to render_template :show
      end
    end

    include_examples 'サインインしていない時'
  end
end
