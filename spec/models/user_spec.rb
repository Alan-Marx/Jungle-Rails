require 'rails_helper'

RSpec.describe User, type: :model do

  subject {
      described_class.new(
        first_name: 'Alan',
        last_name: 'Marx',
        email: 'alanmarx@hotmail.com',
        password: 'labrador',
        password_confirmation: 'labrador'
      )
    }

  describe "Validations" do

    describe "password" do

      it "is not valid when password and passsord confirmation fields are missing" do
        subject.password = nil
        subject.password_confirmation = nil
        expect(subject).to_not be_valid
        expect(subject.errors.full_messages).to eq(["Password can't be blank","Password confirmation can't be blank"])
      end

      it "is not valid if the password and password confirmation do not match" do
        subject.password_confirmation = 'labradors'
        expect(subject).to_not be_valid
        expect(subject.errors.full_messages).to eq(["Password confirmation doesn't match Password"])
      end

    end
    
    it "is not valid if email (not case sensitive) has already been used" do
      subject.save
      subject_2 = User.new(
          first_name: 'Alan',
          last_name: 'Marx',
          email: 'ALANmarx@hotmail.com',
          password: 'labrador',
          password_confirmation: 'labrador'
        )
      expect(subject_2).to_not be_valid
      expect(subject_2.errors.full_messages).to eq(["Email has already been taken"])
    end

    it "is not valid if email, first name or last name are not present" do
      subject.email, subject.first_name, subject.last_name  = nil
      expect(subject).to_not be_valid
      expect(subject.errors.full_messages).to eq(["Email can't be blank", "First name can't be blank", "Last name can't be blank"])
    end

    it "is not valid if password is less than 5 characters" do
      subject.password = 'labr'
      subject.password_confirmation = 'labr'
      expect(subject).to_not be_valid
      expect(subject.errors.full_messages).to eq(["Password is too short (minimum is 5 characters)"])
    end

  end

  describe ".authenticate_with_credentials" do

    it "should return user instance if email and password are correct" do
      subject.save
      expect(User.authenticate_with_credentials('alanmarx@hotmail.com', 'labrador')).to eq(subject)
    end

    it "should return user instance if correct email has whitespace at the beginning or end" do
      subject.save
      expect(User.authenticate_with_credentials('  alanmarx@hotmail.com  ', 'labrador')).to eq(subject)
    end

    it "should return user instance regardless of the case of the correct email" do
      subject.save
      expect(User.authenticate_with_credentials('alanMArx@hotmail.com', 'labrador')).to eq(subject)
    end

    it "should return nil if email does not exist" do
      subject.save
      expect(User.authenticate_with_credentials('', 'labrador')).to eq(nil)
    end

    it "should return nil if password is incorrect" do
      subject.save
      expect(User.authenticate_with_credentials('alanmarx@hotmail.com', 'labradors')).to eq(nil)
    end

  end

end
