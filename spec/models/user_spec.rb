require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it 'validates new user' do
      @user = User.new(first_name: "Brian", last_name: "Regal", email: "example@yahoo.com", password: "12345", password_confirmation: "12345")
      @user.save
      expect(@user.save).to be true
    end

    it 'first name cannot be blank' do
      @user = User.new(first_name: nil, last_name: nil, email: "example@yahoo.com", password: "12345", password_confirmation: "12345")
      @user.save
      expect(@user.errors.full_messages).to include("First name can't be blank")
    end

    it 'last name cannot be blank' do
      @user = User.new(first_name: "Brain", last_name: nil, email: "example@yahoo.com", password: "12345", password_confirmation: "12345")
      @user.save
      expect(@user.errors.full_messages).to include("Last name can't be blank")
    end

    it 'passwords must match' do
      @user = User.new(first_name: "Brian", last_name: "Regal", email: "example@yahoo.com", password: "12345", password_confirmation: "67890")
      @user.save

      expect(@user.save).to be false
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end

    it 'password cannot be blank' do
      @user = User.new(first_name: "Brian", last_name: "Regal", email: "example@yahoo.com", password: nil, password_confirmation: nil)
      @user.save
      expect(@user.save).to be false
      expect(@user.errors.full_messages).to include("Password can't be blank")
    end

    it 'password must be longer than 5 characters' do
      @user = User.new(first_name: "Brian", last_name: "Regal", email: "example@yahoo.com", password: nil, password_confirmation: nil)
      @user.save
      
      expect(@user.errors.full_messages).to include("Password is too short (minimum is 5 characters)")
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

  describe '.authenticate_with_credentials' do
    before(:each) do 
      @user = User.new(first_name: "Brian", last_name: "Regal", email: "example@yahoo.com", password: "12345", password_confirmation: "12345")
      @user.save
    end

    it 'should not authenticate if password is wrong' do
      params = { email: "example@yahoo.com", password: "67890" }
      @user = User.authenticate_with_credentials(params[:email], params[:password])

      expect(@user).to be_nil
    end

    it 'should not authenticate if email does not exist' do
      params = { email: "wrong@yahoo.com", password: "12345" }
      @user = User.authenticate_with_credentials(params[:email], params[:password])

      expect(@user).to be_nil
    end

    it 'should authenticate if email and password match' do
      params = { email: "example@yahoo.com", password: "12345" }
      @user = User.authenticate_with_credentials(params[:email], params[:password])

      expect(@user).to be_present
    end

    it 'should authenticate if email has whitespace' do
      params = { email: " example@yahoo.com ", password: "12345" }
      @user = User.authenticate_with_credentials(params[:email], params[:password])

      expect(@user).to be_present
    end

    it 'should authenticate if email has wrong cases' do
      params = { email: "EXAMPLE@yahoo.com", password: "12345" }
      @user = User.authenticate_with_credentials(params[:email], params[:password])

      expect(@user).to be_present
    end

  end
end
