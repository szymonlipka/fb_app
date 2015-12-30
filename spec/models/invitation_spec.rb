require 'rails_helper'
RSpec.describe Invitation, type: :model do
  describe 'validates' do
    it { should validate_presence_of(:inviter_username)}
  end
  describe 'associations' do
    it { should belong_to :user }
    it { should belong_to :group }
  end
  describe 'db columns' do
    it { should have_db_column :user_id }
    it { should have_db_column :inviter_username }
    it { should have_db_column :group_id }
  end
end
