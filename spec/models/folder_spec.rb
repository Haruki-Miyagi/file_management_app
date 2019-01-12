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

  describe 'validation' do
    it { is_expected.to validate_presence_of(:name) }
  end

  describe 'association' do
    it { is_expected.to belong_to(:user).class_name('User') }
    it { is_expected.to have_many(:room).class_name('Room') }
  end
end
