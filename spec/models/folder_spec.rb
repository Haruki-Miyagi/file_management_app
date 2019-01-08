require 'rails_helper'

RSpec.describe Folder, type: :model do
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

  describe 'summit' do
    context 'Rootフォルダが作成済みである場合' do
      it 'Rootフォルダのインスタンスが返されること' do
        root = create(:folder, name: 'Root', description: 'Root Folder')
        expect(subject.class.summit).to eq(root)
      end
    end
  end
end
