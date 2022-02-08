require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do

    it 'creates user succesfully' do
      @user = User.create(name: 'Kate', email: 'test@email.com', password: '123123', password_confirmation: '123123')

      expect(@user).to be_valid
      expect(@user.password).to eql(@user.password_confirmation)
      expect(@user.errors.full_messages.count).to be 0
    end

    it 'does not create users and has error if password and password confirmation do not match' do
      @user = User.create(name: 'Kate', email: 'test@email.com', password: '123123', password_confirmation: '123456')
      expect(@user).to_not be_valid
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end 

    it 'does not create user and has error if email is not unique' do
      @user1 = User.create(name: 'Kate', email: 'test@email.com', password: '123123', password_confirmation: '123123')
      @user2 = User.create(name: 'Matt', email: 'TEST@EMAIL.com', password: '456789', password_confirmation: '456789')
      
      expect(@user1).to be_valid
      expect(@user2).to_not be_valid
      expect(@user2.errors.full_messages).to include("Email has already been taken")
    end  

    it 'does not create user and has error if name is blank' do
      @user = User.create(name: nil, email: 'test@email.com', password: '123123', password_confirmation: '123123')
      
      expect(@user).to_not be_valid
      expect(@user.errors.full_messages).to include("Name can't be blank")
    end  

  end

  describe '.authenticate_with_credentials' do
    # examples for this class method here
  end

  
end
