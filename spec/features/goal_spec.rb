require 'spec_helper'
require 'rails_helper'

feature 'goals CRUD' do
  background(:each) do
    sign_up('featuretestuser', 'password')
  end

  feature 'creating a goal' do
    scenario "There is a 'New Goal' page" do
      visit '/goals/new'
      expect(page).to have_content('New Goal')
    end
    scenario 'Users can create a goal' do
      text = Time.now
      create_public_goal(user_id('featuretestuser'), text)
      expect(page).to have_content(text)
    end
    scenario 'unauthorized users are redirected to login page' do
      sign_out
      create_public_goal(user_id('featuretestuser'), text)
      expect(page).to have_content('Log In')
    end
  end

  feature 'reading goals' do
    scenario 'Users can\'t read the private goals of others' do
      text = 'PRIVATE PRIVATE PRIVATE'
      sign_up('new_user')
      create_private_goal(text)
      sign_in_as('featuretestuser', 'password')
      visit '/goals'
      expect(page).not_to have_content(text)
    end

    scenario 'Users can read their own public goals' do
      text = 'my public post'
      create_public_goal(user_id('featuretestuser'), text)
      visit '/goals'
      expect(page).to have_content('my public post')
    end

    scenario 'Users can read their own private goals' do
      text = 'my private post'
      create_private_goal(text)
      visit '/goals'
      expect(page).to have_content(text)
    end
  end
  feature 'updating goals' do
    scenario "there is an 'Edit Goal' page" do
      create_public_goal(user_id('featuretestuser'), 'to be edited')
      visit_edit_page
      expect(page).to have_content('Edit Goal')
    end

    scenario 'User can edit their own goals' do
      create_public_goal(user_id('featuretestuser'), 'to be edited')
      visit_edit_page
      edit_goal('has been edited')
      expect(page).to have_content('Edited Goal')
    end

    scenario 'User must log in to edit goals' do
      create_public_goal(user_id('featuretestuser'), 'to be edited')
      sign_out
      visit_edit_page(Goal.first)
      expect(page).to have_content('Log In')
    end

    scenario 'User cant edit others goals' do
      create_public_goal(user_id('featuretestuser'), 'to be edited')
      sign_out
      sign_up('new_user')
      visit_edit_page(Goal.first)
      edit_goal('I cant do this')
      expect(page).not_to have_content('I cant do this')
    end
  end

  feature 'Deleting goals' do 
    scenario 'User can delete their own posts' do
      create_public_goal(user_id('featuretestuser'))
      visit_edit_page
      click_on 'DELETE POST'
      expect(page).to have_content('Deleted Goal')
    end
    scenario 'User cant delete the goals of others' do
      sign_up('new_user')
      create_public_goal(user_id('new_user'), 'can\'t delete this')
      sign_in_as('featuretestuser', 'password')
      visit_edit_page
      expect(page).not_to have_content('can\'t delete this')
    end
  end

  feature 'Completing Goals' do
    scenario 'Users can see the status of goals' do
      create_public_goal(user_id('featuretestuser'))
      visit '/goals/' + Goal.last.id.to_s
      expect(page).to have_content('Incomplete')
    end
    scenario 'Users can toggle their own task\'s completion status' do
      create_public_goal(user_id('featuretestuser'))
      mark_goal_complete
      expect(page).to have_content('Complete')
    end
    scenario 'Users can mark their own tasks as incomplete' do
      create_public_goal(user_id('featuretestuser'))
      mark_goal_complete
      mark_goal_incomplete
      expect(page).to have_content('Incomplete')
    end
  end
end
