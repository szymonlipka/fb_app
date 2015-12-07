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
	end
	describe 'initialization' do
		let(:user1) {User.create!(:username => 'test', :email => 'test@t.t', :password => '123456')}
		let(:user2) {User.create!(:username => 'test2', :email => 'test2@t.t', :password => '123456')}
		let(:group) {Group.create!(:name => 'Grupa')}
		it "shouldn't be able to add other user when you aren't in group" do
			expect(user1.add_to_group(group.id, user2.id)).not_to be_truthy
		end
		it "should be able to add other user when you are in group" do
			user1.groups << group
			user1.add_to_group(group.id, user2.id)
			expect(user2.groups.include?(group)).to be_truthy
		end
	end
	describe 'bad email address' do
		it 'should raise error' do
			expect{User.create!(:username => 'hh', :email => 'lklj', :password => '123456')}.to raise_error(ActiveRecord::RecordInvalid)
		end
	end
end