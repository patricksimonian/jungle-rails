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

    it 'should fail if email is not unique with different case' do
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
        email: 'BOb@mail.Com'
        })
      expect(@user2.save).to be false
    end

    it 'should fail if email is not present' do
      @user = User.new({
        first_name: 'bob',
        last_name: 'rocks',
        password: 'apples',
        password_confirmation: 'apples'
        })

      expect(@user.save).to be false
    end

    it 'should fail if first_name is not present' do
      @user = User.new({
        last_name: 'rocks',
        password: 'apples',
        password_confirmation: 'apples',
        email: "bob@mail.com"
        })

      expect(@user.save).to be false
    end

    it 'should fail if last_name is not present' do
      @user = User.new({
        first_name: 'bob',
        password: 'apples',
        password_confirmation: 'apples',
        email: "bob@mail.com"
        })

      expect(@user.save).to be false
    end

    it 'should fail if password is less than 1 characters long' do
      @user = User.new({
        first_name: 'bob',
        last_name: 'rocks',
        password: 'a',
        password_confirmation: 'a',
        email: "bob@mail.com"
        })

      expect(@user.save).to be false
    end

  end

  describe '.authenticate_with_credentials' do

     it 'should return nil if user enters incorrect email' do
        user = User.new({
        first_name: 'bob',
        last_name: 'rocks',
        password: 'apple',
        password_confirmation: 'apple',
        email: "bob@mail.com"
        })
        user.save
        @user = User.authenticate_with_credentials("test.mail.com", "apple")

        expect(@user).to be nil
     end


     it 'should return user if user enters correct pw and correct email' do
        user = User.new({
        first_name: 'bob',
        last_name: 'rocks',
        password: 'apple',
        password_confirmation: 'apple',
        email: "bob@mail.com"
        })
        user.save
        @user = User.authenticate_with_credentials("bob@mail.com", "apple")

        expect(@user).to eql user
     end


     it 'should return nil if user enters incorrect pw' do
        user = User.new({
        first_name: 'bob',
        last_name: 'rocks',
        password: 'apple',
        password_confirmation: 'apple',
        email: "bob@mail.com"
        })
        user.save
        @user = User.authenticate_with_credentials("bob@mail.com", "applessdfas")

        expect(@user).to be nil
     end


     it 'should return user if user enters credentials correctly with extra white space on email' do
        user = User.new({
        first_name: 'bob',
        last_name: 'rocks',
        password: 'apple',
        password_confirmation: 'apple',
        email: "bob@mail.com"
        })
        user.save
        @user = User.authenticate_with_credentials(" bob@mail.com ", "apple")

        expect(@user).to eql user
     end


     it 'should return user if user enters correct pw and correct email but with case difference' do
        user = User.new({
        first_name: 'bob',
        last_name: 'rocks',
        password: 'apple',
        password_confirmation: 'apple',
        email: "bob@mail.com"
        })
        user.save
        @user = User.authenticate_with_credentials("Bob@MAil.com", "apple")

        expect(@user).to eql user
     end
  end
end
