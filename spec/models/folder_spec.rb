require 'rails_helper'

RSpec.describe Folder, type: :model do
  let!(:root) { create(:folder, name: 'Root', description: 'Root Folder') }

  describe 'column' do
    it { is_expected.to have_db_column(:name) }
    it { is_expected.to have_db_column(:description) }
    it { is_expected.to have_db_column(:ancestry) }
    it { is_expected.to have_db_column(:user_id) }
    it { is_expected.to have_db_column(:created_at) }
    it { is_expected.to have_db_column(:updated_at) }
  end

  describe 'association' do
    it { is_expected.to belong_to(:user).class_name('User') }
  end

  describe 'scope :order_by_preference' do
    let!(:folders) { create_list(:folder, 5, parent_id: root.id) }

    it '降順で並べ替えること' do
      expect_value = folders.reverse.map(&:id)
      expect(root.children.order_by_preference.pluck(:id)).to eq(expect_value)
    end
  end

  describe 'summit' do
    context 'Rootフォルダが作成済みである場合' do
      it 'Rootフォルダのインスタンスが返されること' do
        expect(subject.class.summit).to eq(root)
      end
    end
  end
end
