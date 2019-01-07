require 'rails_helper'

RSpec.describe FoldersController, type: :controller do
  let(:user) { create(:user) }

  describe 'GET #index' do
    before { sign_in(user) }
    let!(:folder) do
      create(:folder,
             name: 'Root',
             description: 'Root Folder')
    end

    def do_render
      get :index
    end

    it 'has a 200 status code' do
      do_render
      expect(response).to have_http_status(:success)
    end

    it 'assigns @folder' do
      do_render
      expect(assigns(:folder)).to eq(folder)
    end

    it 'renders the :index template' do
      do_render
      expect(response).to render_template :index
    end
  end

  describe 'GET #show' do
    before { sign_in(user) }
    let(:folder) { create(:folder) }

    it 'returns http success' do
      get :show, params: { id: folder.id }
      expect(response).to have_http_status(:success)
    end
  end
end
