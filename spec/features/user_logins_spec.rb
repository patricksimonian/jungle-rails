require 'rails_helper'

RSpec.feature "User can login and be sent to home page", type: :feature do

  before :each do
    @user = User.create!(first_name: Test,
      last_name: Bob,
      password: apples,
      password_confirmation: apples,
      )
end
