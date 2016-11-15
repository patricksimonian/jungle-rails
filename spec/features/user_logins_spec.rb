require 'rails_helper'

RSpec.feature "User can login and be sent to home page", type: :feature, js: true do

  before :each do
    @user = User.create!(first_name: 'Test',
      last_name: 'Bob',
      password: 'apples',
      password_confirmation: "apples",
      email: "bob@bob.com"
      )
  end
    scenario 'can login succesfully and be redirected to home page' do
      visit root_path
      click_on 'login'
      within_window('.modal-dialogue') do
        fill_in 'email', with: @user.email
        fill_in 'password', with: @user.password
        click_on 'login'
      end
      expect(page).to have_content 'logout'
    end
end
