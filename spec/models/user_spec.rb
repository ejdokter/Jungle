require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it 'validates new user' do
      @user = User.new(first_name: "Brian", last_name: "Regal", email: "example@yahoo.com", password: "12345", password_confirmation: "12345")
      @user.save

      expect(@user.save).to be true
    end

    it 'name cannot be blank' do
      @user = User.new(first_name: nil, last_name: "Regal", email: "example@yahoo.com", password: "12345", password_confirmation: "12345")
      @user.save
      p @user.errors.full_messages
      expect(@user.errors.full_messages).to include("Name can't be blank")
    end

    it 'passwords must match' do
      @user = User.new(first_name: "Brian", last_name: "Regal", email: "example@yahoo.com", password: "12345", password_confirmation: "67890")
      @user.save

      expect(@user.save).to be false
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end

    it 'should reject user if no password is given' do
      @user = User.new(first_name: "Brian", last_name: "Regal", email: "example@yahoo.com", password: nil, password_confirmation: nil)
      @user.save
     
      expect(@user.save).to be false
      expect(@user.errors.full_messages).to include("Password can't be blank")
    end

    it 'reject user if email is blank' do
      @user = User.new(first_name: "Brian", last_name: "Regal", email: nil, password: "12345", password_confirmation: "12345")
      @user.save

      p @user.errors.full_messages
      expect(@user.errors.full_messages).to include("Email can't be blank")
    end

    it 'should reject user if email already exists' do
      @user1 = User.new(first_name: "Brian", last_name: "Regal", email: "example@yahoo.com", password: "12345", password_confirmation: "12345")
      @user2 = User.new(first_name: "Butch", last_name: "Regal", email: "example@yahoo.com", password: "12345", password_confirmation: "12345")
      @user1.save
      @user2.save

      expect(@user2.errors.full_messages).to include("Email has already been taken")

    end
  end
end
