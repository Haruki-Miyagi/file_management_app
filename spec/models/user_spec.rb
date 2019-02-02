require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'column' do
    it { is_expected.to have_db_column(:email) }
    it { is_expected.to have_db_column(:encrypted_password) }
    it { is_expected.to have_db_column(:reset_password_token) }
    it { is_expected.to have_db_column(:reset_password_sent_at) }
    it { is_expected.to have_db_column(:remember_created_at) }
    it { is_expected.to have_db_column(:admin) }
    it { is_expected.to have_db_column(:created_at) }
    it { is_expected.to have_db_column(:updated_at) }
  end

  describe 'validation' do
    it { is_expected.to validate_presence_of(:email) }
  end

  describe 'association' do
    it { is_expected.to have_many(:folders).class_name('Folder') }
    it { is_expected.to have_many(:rooms).class_name('Room') }
    it { is_expected.to have_many(:documents).class_name('Document') }
    it { is_expected.to have_many(:messages).class_name('Message') }
  end
end
