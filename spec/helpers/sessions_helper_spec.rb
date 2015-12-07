require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the SessionsHelper. For example:
#
# describe SessionsHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe SessionsHelper, type: :helper do
	let(:user) {User.create!(:username => 'Szymon', :email => 'szymon.lipka@op.pl', :password => '123456')}
	it 'logs in user' do
		expect(log_in(user)).to eq(user.id)
		expect(current_user).to eq(user)
		expect(logged_in?).to be_truthy
	end
	it 'logs out user' do
		log_in(user)
		log_out
		expect(current_user).to be_nil
		expect(logged_in?).to be_falsy
	end
end
