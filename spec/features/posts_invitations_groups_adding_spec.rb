require "rails_helper"

describe "user" do
  before(:each) do
    @user = User.create!(:username => 'lolz', :email => 'admin@example.com', password: '123456')  
  end
  it 'can create group, add posts in the group and invite to his group' do
    visit '/sign_in'
    fill_in 'Email', :with => 'admin@example.com'
    fill_in 'Password', :with => '123456'
    click_button 'Log in'
    visit dashboard_path(@user.id)
    find('.create-group').set('Project Runway')
    click_on("Załóż grupę")
    expect(@user.groups.last.name).to eq('Project Runway')
    expect(Group.last.name).to eq('Project Runway')
    visit group_path(Group.last)
    fill_in 'post_content', with: 'To jest post'
    click_on("Napisz post")
    expect(Group.last.posts.last.content).to eq('To jest post')
    expect(Group.last.posts.count).to eq(1)
    user2 = User.create!(:username => 'example', :email => 'example@example.com', password: '123456')
    find('#username').set('example')
    click_button("Dodaj do grupy")
    expect(Invitation.last.inviter_username).to eq('lolz')
    expect(Invitation.last.group_name).to eq('Project Runway')
    expect(Invitation.last.user).to eq(user2)
    expect(Invitation.last.group).to eq(Group.last)
    expect(user2.groups.last).to eq(nil)
    visit '/'
    click_on("Log out")
    visit '/sign_in'
    fill_in 'Email', :with => 'example@example.com'
    fill_in 'Password', :with => '123456'
    click_button 'Log in'
    visit dashboard_path(user2.id)
    click_on 'Accept'
    expect(user2.groups.last.name).to eq('Project Runway')
  end
  it "can't log in with bad data" do
    visit '/sign_in'
    fill_in 'Email', :with => 'asdasd'
    fill_in 'Password', :with => 'asd'
    click_button 'Log in'
    expect(page.html).to match(/Invalid email/)
  end
  it "can't register with bad data" do
    visit '/sign_up'
    fill_in 'user_email', :with => 'asdasd'
    fill_in 'user_username', with: 'blabla'
    fill_in 'user_password', with: '123'
    fill_in 'user_password_confirmation', with: '213'
    click_button 'Sign up'
    expect(page.html).to match(/Password is too short/)
    expect(page.html).to match(/Password confirmation doesn&#39;t match Password/)
    expect(page.html).to match(/Email is invalid/)
  end
  it "can register with good data" do
    visit '/sign_up'
    fill_in 'user_email', :with => 'asdasd@wq.pl'
    fill_in 'user_username', with: 'blabla'
    fill_in 'user_password', with: '123456'
    fill_in 'user_password_confirmation', with: '123456'
    click_button 'Sign up'
    expect(User.last.email).to eq('asdasd@wq.pl')
    expect(User.last.username).to eq('blabla')
  end
end