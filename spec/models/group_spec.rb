require 'rails_helper'
RSpec.describe Group, type: :model do
  describe 'validates' do
    it { should validate_presence_of(:name)}
  end
  describe 'associations' do
    it { should have_many :users }
    it { should have_many :memberships }
    it { should have_many :posts }
    it { should have_many :users_invited }
  end
end
