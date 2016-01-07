require 'rails_helper'
RSpec.describe User do

  describe 'validates' do
      it { should validate_presence_of(:email)}
      it { should validate_presence_of(:password)}
      it { should validate_presence_of(:first_name)}
      it { should validate_presence_of(:last_name)}
    end

  describe 'associations' do
      it { should have_many :groups }
      it { should have_many :memberships }
      it { should have_many :posts }
      it { should have_many :invitations }
      it { should have_many :friendships }
      it { should have_many :friends }
      it { should have_many :inverse_friendships }
      it { should have_many :inverse_friends }
  end

  describe 'db columns' do
    it { should have_db_column :username }
    it { should have_db_column :email }
    it { should have_db_column :first_name }
    it { should have_db_column :last_name }
    it { should have_db_column :password_digest }
    it { should have_db_column :provider }
    it { should have_db_column :uid }
  end

  describe 'invitations' do
    let(:user) {User.create!(first_name: 'Szymon', last_name: 'Lipka', :username => 'test', :email => 'test@t.t', :password => '123456')}
    let(:group) {Group.create!(:name => 'Grupa')}

    it 'accept group invite' do
      @invitation = user.invitations.build(inviter_username: 'Jalowiec')
      group.invitations << @invitation
      expect(@invitation).to eq(Invitation.last)
      user.accept_invite(@invitation)
      expect(user.groups.last).to eq(group)
      expect(Invitation.last).not_to eq(@invitation)
    end

    it 'accept friend invite' do
      friend = User.create(first_name: 'Szymon', last_name: 'Lipka', :username => 'test', :email => 'test@t.tt', :password => '123456')
      @invitation = user.invitations.build(inviter_username: 'Jalowiec', friend_id: friend.id)
      @invitation.save
      expect(@invitation).to eq(Invitation.last)
      user.accept_invite(@invitation)
      expect(user.friends.last).to eq(friend)
      expect(friend.friends.last).to eq(user)
      expect(Invitation.last).not_to eq(@invitation)
    end

    it 'decline' do
      @invitation = user.invitations.build(inviter_username: 'Jalowiec')
      group.invitations << @invitation
      user.decline_invite(@invitation)
      expect(Invitation.last).not_to eq(@invitation)
      expect(user.groups.last).not_to eq(group)
    end

  end
  # describe 'initialization' do
  #   let(:user) {User.create!(:username => 'test', :email => 'test@t.t', :password => '123456')}
  #   let(:group) {Group.create!(:name => 'Grupa')}

  #   it "adding user to group" do
  #     expect(user.add_to_group(group.id)).to be_truthy
  #     expect(user.groups.include?(group)).to be_truthy
  #   end

  #   # it "should be able to add other user when you are in group" do
  #   #   user1.groups << group
  #   #   expect(user2.add_to_group(group.id)).to be_truthy
  #   #   expect(user2.groups.include?(group)).to be_truthy
  #   # end

  # end
  describe 'bad email address' do
    it 'should raise error' do
      expect{User.create!(first_name: 'Szymon', last_name: 'Lipka', :username => 'hh', :email => 'lklj', :password => '123456')}.to raise_error(ActiveRecord::RecordInvalid)
    end
  end
end