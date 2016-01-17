require 'rails_helper'

RSpec.describe Membership, type: :model do
    describe 'db columns' do
    it { should have_db_column :user_id }
    it { should have_db_column :group_id }
  end
  describe 'associations' do
    it { should belong_to :group }
    it { should belong_to :user }
  end
end
