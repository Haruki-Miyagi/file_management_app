require 'rails_helper'

RSpec.describe Document, type: :model do
  describe 'column' do
    it { is_expected.to have_db_column(:file_name) }
    it { is_expected.to have_db_column(:uploaded_file) }
    it { is_expected.to have_db_column(:description) }
    it { is_expected.to have_db_column(:user_id) }
    it { is_expected.to have_db_column(:room_id) }
    it { is_expected.to have_db_column(:created_at) }
    it { is_expected.to have_db_column(:updated_at) }
  end

  describe 'validation' do
    it { is_expected.to validate_presence_of(:uploaded_file) }
  end

  describe 'association' do
    it { is_expected.to belong_to(:user).class_name('User') }
    it { is_expected.to belong_to(:room).class_name('Room') }
  end

  describe 'scope :order_by_preference' do
    let(:documents) { create_list(:document, 3) }

    it '降順で並べ替えること' do
      expect_value = documents.reverse.map(&:id)
      expect(Document.order_by_preference.pluck(:id)).to eq(expect_value)
    end
  end

  describe 'image?' do
    let(:document) { create(:document, uploaded_file: uploaded_file) }

    context '指定以外の拡張子の場合' do
      let(:uploaded_file) do
        Rack::Test::UploadedFile.new(
          Rails.root.join('spec', 'up_folder', 'file01.xlsx'), 'application/vnd.ms-excel'
        )
      end

      it '許可しないこと' do
        expect(document.image?).to be_blank
      end
    end

    context '指定の拡張子の場合' do
      let(:uploaded_file) do
        Rack::Test::UploadedFile.new(
          Rails.root.join('spec', 'up_folder', 'pdffile01.png'), 'image/png'
        )
      end

      it '許可すること' do
        expect(document.image?).to be_present
      end
    end
  end
end
