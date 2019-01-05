require 'rails_helper'

RSpec.describe FoldersController, type: :controller do
  let(:user) { create(:user) }

  describe 'GET #show' do
    before { sign_in(user) }
    let(:folder) { create(:folder) }
    it 'returns http success' do
      get :show, params: { id: folder.id }
      expect(response).to have_http_status(:success)
    end
  end
end
