require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe "GET #new" do
    it "should render the new page" do
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe "POST #create" do
    context "when params are invalid" do
      it "should render the new page" do
        post :create, params: { user: {username: 'kjath', password: '' } }
        expect(response).to render_template(:new)
        expect(flash.now[:errors]).to eql("invalid username or password")
      end
    end
    context "when params are valid" do
      it "should create the new user" do
        post :create, params: { user: {username: 'kath', password: 'maroon' } }
        expect(User.find_by(username: 'kath')).not_to eql(nil)
      end
    end
  end
end
