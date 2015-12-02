require 'rails_helper'
RSpec.describe User do
	describe 'initialization' do
		let(:user1) {User.create!(:username => 'Szymon', :email => 'szymon.lipka@op.pl', :password => '123456')}
		let(:user2) {User.create!(:username => 'NieSzymon', :email => 'szymon.lipka1@op.pl', :password => '123456')}
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
end