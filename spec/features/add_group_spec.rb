require "rails_helper"

describe "logged user" do
	before(:each) do
        @user = User.create!(:username => 'lolz', :email => 'admin@example.com', password: '123456')
    end
	it 'can create group, add posts in the group and invite to his group' do
	    visit '/login'
		fill_in 'Email', :with => 'admin@example.com'
		fill_in 'Password', :with => '123456'
    	click_button 'Log in'
		find('.create-group').set('Project Runway')
		click_on("Załóż grupę")
		expect(@user.groups.last.name).to eq('Project Runway')
		expect(Group.last.name).to eq('Project Runway')
		visit group_path(Group.last)
		print page.html
		fill_in 'post_content', with: 'To jest post'
		click_on("Napisz post")
		expect(Group.last.posts.last.content).to eq('To jest post')
		expect(Group.last.posts.count).to eq(1)
		user2 = User.create!(:username => 'example', :email => 'example@example.com', password: '123456')
		fill_in 'invite_username', with: user2.username
		click_button("Dodaj do grupy")
		expect(Group.last.users.last).to eq(user2)
		expect(Group.last.users.count).to eq(2)
	end
end