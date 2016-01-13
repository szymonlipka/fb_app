require 'rails_helper'
RSpec.describe Post, type: :model do
  describe 'validates' do
      it { should validate_presence_of(:content)}
    end
    describe 'associations' do
      it { should belong_to :user }
      it { should belong_to :group }
  end
  describe 'db columns' do
    it { should have_db_column :content }
    it { should have_db_column :user_id }
    it { should have_db_column :created_at }
    it { should have_db_column :group_id }
  end
end