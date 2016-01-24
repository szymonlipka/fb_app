require "rails_helper"

describe "user" do
  before(:each) do
    @user = User.create!(first_name: 'Szymon', last_name: 'Lipka', :username => 'lolz', :email => 'admin@example.com', password: '123456')  
  end
  it 'should be able to create groups and and friends' do
    visit '/sign_in'
    fill_in 'Email', :with => 'admin@example.com'
    fill_in 'Password', :with => '123456'
    click_button 'Log in'
    visit dashboard_path(@user.id)
    find('.create-group').set('Project Runway')
    click_on("Załóż grupę")
    expect(@user.groups.last.name).to eq('Project Runway')
    expect(Group.last.name).to eq('Project Runway')
    user2 = User.create!(first_name: 'Szymon', last_name: 'Lipka', :username => 'example', :email => 'example@example.com', password: '123456')
    visit dashboard_path(user2.id)
    click_button("Add Friend")
    user2.accept_invite(Invitation.last)
    expect(@user.friends.last).to eq(user2)
    expect(user2.friends.last).to eq(@user)
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
    fill_in 'user_first_name', with: 'Szymon'
    fill_in 'user_last_name', with: 'Lipka'
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
    fill_in 'user_first_name', with: 'Szymon'
    fill_in 'user_last_name', with: 'Lipka'
    fill_in 'user_password', with: '123456'
    fill_in 'user_password_confirmation', with: '123456'
    click_button 'Sign up'
    expect(User.last.email).to eq('asdasd@wq.pl')
    expect(User.last.username).to eq('blabla')
  end
end