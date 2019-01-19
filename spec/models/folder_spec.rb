require 'rails_helper'

RSpec.describe Folder, type: :model do
  let(:admin_user) { create(:user, :admin) }
  let!(:root) { create(:folder, name: 'Root', description: 'Root Folder', user_id: admin_user.id) }

  describe 'column' do
    it { is_expected.to have_db_column(:name) }
    it { is_expected.to have_db_column(:description) }
    it { is_expected.to have_db_column(:ancestry) }
    it { is_expected.to have_db_column(:user_id) }
    it { is_expected.to have_db_column(:created_at) }
    it { is_expected.to have_db_column(:updated_at) }
  end

  describe 'validation' do
    it { is_expected.to validate_presence_of(:name) }
  end

  describe 'association' do
    it { is_expected.to belong_to(:user).class_name('User') }
    it { is_expected.to have_many(:rooms).class_name('Room') }
  end

  describe 'scope :order_by_preference' do
    let!(:folders) { create_list(:folder, 5, parent_id: root.id) }

    it '降順で並べ替えること' do
      expect_value = folders.reverse.map(&:id)
      expect(root.children.order_by_preference.pluck(:id)).to eq(expect_value)
    end
  end

  describe 'scope :unset_root' do
    let!(:folders) { create_list(:folder, 5, parent_id: root.id) }

    it 'rootレコードが含まないこと' do
      expect(Folder.unset_root).to_not include(root)
    end
  end

  describe 'summit' do
    context 'Rootフォルダが作成済みである場合' do
      it 'Rootフォルダのインスタンスが返されること' do
        expect(subject.class.summit).to eq(root)
      end
    end
  end

  describe 'all_childrens' do
    let!(:folders) { create_list(:folder, 5, parent_id: root.id) }
    let(:rooms) { create_list(:room, 3, user_id: admin_user.id, folder_id: root.id) }

    it 'rootフォルダ直下のフォルダ(rootフォルダも含む)があること' do
      expected_value = folders + rooms
      expect(root.all_childrens).to eq(expected_value)
    end
  end

  describe 'root_below_folder' do
    let(:folders) { create_list(:folder, 5, parent_id: root.id) }
    let(:resource) { create(:folder, parent_id: folders.first.id) }

    it 'rootレコードが以外の子フォルダが取得できること' do
      expect(resource.root_below_folder).to_not include(root)
    end
  end
end
