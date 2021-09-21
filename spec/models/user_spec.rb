require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    # validation tests/examples here
    it 'should pass if all fields are set' do
      @user = User.new(name:'chris', email:"chris@gmail.com", password:'11111111', password_confirmation:'11111111')
      expect(@user).to be_valid
      expect(@user.errors.full_messages).to_not be_present
    end

    it 'should not pass if the name field is nil' do
      @user = User.new(name:nil, email:"chris@gmail.com", password:'11111111', password_confirmation:'11111111')
      expect(@user).to_not be_valid
      expect(@user.errors.full_messages).to be_present
    end

    it 'should not pass if the email field is nil' do
      @user = User.new(name:nil, email:nil, password:'11111111', password_confirmation:'11111111')
      expect(@user).to_not be_valid
      expect(@user.errors.full_messages).to be_present
    end

    it "is not valid user when password and confirmation do not match" do
      @user = User.new(name:'chris', email:"chris@gmail.com", password:'11111111', password_confirmation:'22222222')
      expect(@user).to_not be_valid
    end

    it "is not valid user when email is the same as another user" do
      @user = User.new(name:'chris', email:"chris@gmail.com", password:'11111111', password_confirmation:'11111111')
      expect(@user).to be_valid
      @user.save!
      @user2 = User.new(name:'c', email:"CHRIS@gmail.com", password:'11111111', password_confirmation:'11111111')
      expect(@user2).to_not be_valid
    end

    it "is not valid user when password is less than 8 characters" do
      @user = User.new(name:'chris', email:"chris@gmail.com", password:'1111111', password_confirmation:'1111111')
      expect(@user).to_not be_valid
    end

  end
  describe '.authenticate_with_credentials' do
    it 'should return user if authentication is succesful' do
      @user = User.new(name:'chris', email:"chrisss@gmail.com", password:'11111111', password_confirmation:'11111111')
      @user.save!
      expect(User.authenticate_with_credentials('chrisss@gmail.com', '11111111')).to eq(@user)
    end

    it 'should succesfully login a user session' do
      @user = User.create(name:'chris', email:"chrisss@gmail.com", password:'11111111', password_confirmation:'11111111')
      expect(User.authenticate_with_credentials('chrisss@gmail.com', '11111111')).to eq(@user)
    end

    it 'should return nil if a user email is incorrect' do
      @user = User.create(name:'chris', email:"chrisss@gmail.com", password:'11111111', password_confirmation:'11111111')
      expect(User.authenticate_with_credentials('chris@gmail.com', '11111111')).to eq(nil)
    end

    it 'should not login/return nil if a user password is incorrect' do
      @user = User.create(name:'chris', email:"chrisss@gmail.com", password:'11111111', password_confirmation:'11111111')
      expect(User.authenticate_with_credentials('chrisss@gmail.com', '1111111111111111')).to eq(nil)
    end

    it 'should succesfully login a user session even if whitespace is added on edge of email' do
      @user = User.create(name:'chris', email:"chrisss@gmail.com", password:'11111111', password_confirmation:'11111111')
      expect(User.authenticate_with_credentials(' chrisss@gmail.com  ', '11111111')).to eq(@user)
    end

    it 'should succesfully login a user session if they mis-case their typed email' do
      @user = User.create(name:'chris', email:"chrisss@gmail.com", password:'11111111', password_confirmation:'11111111')
      expect(User.authenticate_with_credentials('CHRISSS@Gmail.Com', '11111111')).to eq(@user)
    end
  end

end
