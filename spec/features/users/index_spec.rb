require 'rails_helper'

describe 'As a user' do
  describe 'When i am on the root path' do
    it 'I can sign up and login' do
      visit root_path
    
      click_on "Sign Up"
    
      expect(current_path).to eq(new_user_path)
    
      username = "funbucket13"
      password = "test"
    
      fill_in :username, with: username
      fill_in :password, with: password
    
      click_on "Create User"
    
      expect(page).to have_content("Welcome, #{username}!")
    end

    it 'keeps a me logged in after registering' do
      visit root_path
    
      click_on "Sign Up"
    
      username = "funbucket13"
      password = "test"
    
      fill_in :username, with: username
      fill_in :password, with: password
    
      click_on "Create User"
    
      visit profile_path
    
      expect(page).to have_content("Hello, #{username}!")
    end

    it 'I already have an account, I can sign in and see logout options' do
      user = User.create(username: "funbucket13", password: "test")

      visit root_path
  
      click_on "Sign In"
  
      expect(current_path).to eq(login_path)
  
      fill_in :username, with: user.username
      fill_in :password, with: user.password
  
      click_on "Log In"
  
      expect(current_path).to eq(root_path)
  
      expect(page).to have_content("Welcome, #{user.username}")
      expect(page).to have_link("Log Out")
      expect(page).to_not have_link("Register as a User")
      expect(page).to_not have_link("I already have an account")
    end
    
    it "cannot log in with bad credentials" do
      user = User.create(username: "funbucket13", password: "test")
    
      visit root_path
    
      click_on "Sign In"
    
      fill_in :username, with: user.username
      fill_in :password, with: "incorrect password"
    
      click_on "Log In"
    
      expect(current_path).to eq(login_path)
    
      expect(page).to have_content("Incorrect Information.")
    end

    it "I can logout" do
      user = User.create(username: "funbucket13", password: "test")
    
      visit root_path
    
      click_on "Sign In"
    
      fill_in :username, with: user.username
      fill_in :password, with: user.password
    
      click_on "Log In"

      click_on "Log Out"
    
      expect(current_path).to eq(root_path)
    
      expect(page).to have_content("You are logged out!")
    end
  end
end


