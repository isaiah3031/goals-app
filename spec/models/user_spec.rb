require 'rails_helper'

RSpec.describe User, type: :model do
  context "validation" do
    it { should validate_presence_of(:username) }
    it { should validate_presence_of(:password_digest) }
    it do should validate_length_of(:password)
      .is_at_least(6)
      .on(:create)
    end
    it { should validate_uniqueness_of(:username) }
  end

  context "associations" do

  end

  context "after creating a user" do
    user = FactoryBot.create(:user)

    it "should not save password" do
      expect(User.first.password).to eql(nil)
    end
    it "should set the password digest" do
      expect(user.password_digest).not_to eql(nil)
    end
    it "should set the session_token automatically" do
      expect(user.session_token).not_to eql(nil)
    end
    it 'should reset the users session token' do
      token1 = user.session_token
      token2 = user.reset_session_token
      expect(token1).not_to eql(token2)
    end
  end

  context 'check if username and password match' do
    if User.find_by(username: 'username').nil?
      user = FactoryBot.create(:user, username: "username", password: "password")
    end
    it 'should return false if username and password do not match' do
      expect(User.find_by_credentials('username', 'asdf')).to eql(nil)
    end
    it 'should return true if username and password match' do
      expect(User.find_by_credentials('username', 'password').username).to eql('username')
    end
  end

  # maybe a better way to do this one.
  context "generate session token" do
    it 'should create SecureRandom object' do
      expect(User.generate_session_token).to be_a(String) 
    end
  end
end
