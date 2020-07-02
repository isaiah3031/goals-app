require 'spec_helper'
require 'rails_helper'

feature 'the signup process' do
  scenario 'has a new user page' do
    visit new_user_url
    expect(page).to have_content 'New User'
  end

  feature 'signing up a user' do
    scenario 'shows username on the homepage after signup' do
      username = Time.now
      sign_up(username, 'password')
      expect(page).to have_content username
    end
  end
end

feature 'logging in' do
  scenario 'shows username on the homepage after login' do
    if User.find_by(username: 'testuser').nil?
      User.create!(username: 'testuser', password: 'testpass')
    end
    sign_in_as('testuser', 'testpass')
    expect(page).to have_content 'testuser'
  end
end

feature 'logging out' do
  scenario 'begins with a logged out state' do
    visit new_session_url
    expect(page).not_to have_content 'Welcome'
  end
  scenario 'doesn\'t show username on the homepage after logout' do
    if User.find_by(username: 'testuser').nil?
      User.create!(username: 'testuser', password: 'testpass')
    end
    sign_in_as('testuser', 'testpass')
    sign_out
    expect(page).not_to have_content 'Log Out'
  end
end
