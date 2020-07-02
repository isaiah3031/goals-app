module Helpers
  # Logs you in as the username and password combination you provide.
  def sign_in_as(username, password)
    visit new_session_url
    fill_in 'username', with: username
    fill_in 'password', with: password
    click_on 'Log In'
  end

  def sign_out
    click_on 'Log Out'
  end

  # Creates a new user with the username and password you provide.
  # If no password is given, it will use testpass by default.
  def sign_up(username, password = 'testpass')
    visit '/users/new'
    fill_in 'username', with: username
    fill_in 'password', with: 'password'
    click_on 'Create User'
  end

  # Create a public goal by the user you specify.
  # Takes an author's id and will use  'MyText' if no text value is provided
  def create_public_goal(author_id, text = 'MyText')
    FactoryBot.create(:goal, author_id: author_id, text: text)
    visit '/goals'
  end

  # Create a public goal by the user you specify.
  # Takes an author's id and will use  'MyText' if no text value is provided
  def create_private_goal(text = 'MyText')
    visit '/goals/new'
    find('#private').choose
    fill_in 'goal_text', with: text
    click_on 'Create Goal'
    visit '/goals'
  end

  # Visits the specified goals edit page. If none is specified, visits
  # the most recent goal.
  def visit_edit_page(goal = nil)
    goal = Goal.last if goal.nil?
    visit '/goals/' + goal.id.to_s + '/edit'
  end

  # Edit a goal. Uses 'Has been edited' if no text is given'
  def edit_goal(text = 'Has been edited')
    fill_in 'goal_text', with: text
    click_on 'submit'
  end

  def mark_goal_complete
    visit_edit_page
    find('#complete').choose
    click_on 'submit'
  end

  def mark_goal_incomplete
    visit_edit_page
    find('#incomplete').choose
    click_on 'submit'
  end

  # returns user_id that matches the specified username.
  def user_id(username)
    User.find_by(username: username).id
  end
end

