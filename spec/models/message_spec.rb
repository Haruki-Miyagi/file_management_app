require 'rails_helper'

RSpec.describe Message, type: :model do
  describe 'column' do
    it { is_expected.to have_db_column(:content) }
    it { is_expected.to have_db_column(:user_id) }
    it { is_expected.to have_db_column(:room_id) }
    it { is_expected.to have_db_column(:created_at) }
    it { is_expected.to have_db_column(:updated_at) }
  end

  describe 'validation' do
    it { is_expected.to validate_presence_of(:content) }
  end

  describe 'association' do
    it { is_expected.to belong_to(:user).class_name('User') }
    it { is_expected.to belong_to(:room).class_name('Room') }
  end
end
