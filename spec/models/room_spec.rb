require 'rails_helper'

RSpec.describe Room, type: :model do
  describe 'column' do
    it { is_expected.to have_db_column(:name) }
    it { is_expected.to have_db_column(:description) }
    it { is_expected.to have_db_column(:user_id) }
    it { is_expected.to have_db_column(:folder_id) }
    it { is_expected.to have_db_column(:created_at) }
    it { is_expected.to have_db_column(:updated_at) }
  end

  describe 'validation' do
    it { is_expected.to validate_presence_of(:name) }
  end

  describe 'association' do
    it { is_expected.to belong_to(:user).class_name('User') }
    it { is_expected.to belong_to(:folder).class_name('Folder') }
    it { is_expected.to have_many(:documents).class_name('Document') }
    it { is_expected.to have_many(:messages).class_name('Message') }
  end
end
