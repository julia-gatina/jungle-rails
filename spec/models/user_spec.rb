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

    it 'validates that password has minimum length when a user account is being created' do
      @user = User.create(name: 'Julia', email: 'test@email.com', password: '12312', password_confirmation: '12312')
      
      expect(@user).to_not be_valid
      expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
    end  

  end

  describe '.authenticate_with_credentials' do
    it 'does not allow user to log in if passowrd is wrong' do
      @user = User.create(name: 'Julia', email: 'test@email.com', password: 'test123', password_confirmation: 'test123')
      expect(User.authenticate_with_credentials('test@email.com', 'best123')).to be nil    
    end

    it 'allows user to log in if password matches' do
      @user = User.create(name: 'Julia', email: 'test@email.com', password: 'test123', password_confirmation: 'test123')
      expect(User.authenticate_with_credentials('test@email.com', 'test123')).to eq(@user)    
    end

    it 'allows user to log in if email has spaces' do
      @user = User.create(name: 'Julia', email: 'test@email.com', password: 'test123', password_confirmation: 'test123')
      expect(User.authenticate_with_credentials(' test@email.com ', 'test123')).to eq(@user)    
    end

    it 'allows user to log in if email has capital letters' do
      @user = User.create(name: 'Julia', email: 'test@email.com', password: 'test123', password_confirmation: 'test123')
      expect(User.authenticate_with_credentials('TEST@email.com', 'test123')).to eq(@user)    
    end

    

  end

  
end
