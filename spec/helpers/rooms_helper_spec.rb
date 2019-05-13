require 'rails_helper'

RSpec.describe RoomsHelper, type: :helper do
  describe 'like_room?' do
    let(:user) { create(:user) }
    let(:register_room) { create(:room) }
    let(:nregistere_room) { create(:room) }
    let!(:user_controll_room) { create(:user_controll_room, user_id: user.id, room_id: register_room.id) }
    before { allow(helper).to receive(:current_user).and_return(user) }

    context 'お気に入り未登録のとき' do
      it 'trueがかえること' do
        expect(helper.like_room?(register_room)).to be_truthy
      end
    end

    context 'お気に入りに登録済みとき' do
      it 'falseがかえること' do
        expect(helper.like_room?(nregistere_room)).to be_falsey
      end
    end
  end
end
