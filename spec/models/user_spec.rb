require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do

    it 'should save with all four validations (password confirmed)' do
      @user = User.new({
        first_name: 'bob',
        last_name: 'rocks',
        password: 'apples',
        password_confirmation: 'apples',
        email: 'bob@mail.com'
        })

      expect(@user.save).to be true
    end

    it 'should fail if email is not unique' do
      @user1 = User.new({
        first_name: 'bob',
        last_name: 'rocks',
        password: 'apples',
        password_confirmation: 'apples',
        email: 'bob@mail.com'
        })
      @user1.save
      @user2 = User.new({
        first_name: 'tob',
        last_name: 'tocks',
        password: 'apples',
        password_confirmation: 'apples',
        email: 'bob@mail.com'
        })

      expect(@user2.save).to be false
    end


  end
end
