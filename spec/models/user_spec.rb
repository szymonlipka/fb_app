require 'rails_helper'
RSpec.describe User do
  describe 'validates' do
      it { should validate_presence_of(:username)}
      it { should validate_presence_of(:email)}
      it { should validate_presence_of(:password)}
    end
  describe 'associations' do
      it { should have_many :groups }
      it { should have_many :memberships }
      it { should have_many :posts }
  end
  describe 'db columns' do
    it { should have_db_column :username }
    it { should have_db_column :email }
    it { should have_db_column :password_digest }
    it { should have_db_column :provider }
    it { should have_db_column :uid }
  end
  describe 'initialization' do
    let(:user) {User.create!(:username => 'test', :email => 'test@t.t', :password => '123456')}
    let(:group) {Group.create!(:name => 'Grupa')}

    it "adding user to group" do
      expect(user.add_to_group(group.id)).to be_truthy
      expect(user.groups.include?(group)).to be_truthy
    end

    # it "should be able to add other user when you are in group" do
    #   user1.groups << group
    #   expect(user2.add_to_group(group.id)).to be_truthy
    #   expect(user2.groups.include?(group)).to be_truthy
    # end

  end
  describe 'bad email address' do
    it 'should raise error' do
      expect{User.create!(:username => 'hh', :email => 'lklj', :password => '123456')}.to raise_error(ActiveRecord::RecordInvalid)
    end
  end
end