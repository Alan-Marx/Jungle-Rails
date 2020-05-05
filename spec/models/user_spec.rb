require 'rails_helper'

RSpec.describe User, type: :model do
  describe "Validations" do
    subject {
      described_class.new(
        first_name: 'Alan',
        last_name: 'Marx',
        email: 'alanmarx@hotmail.com',
        password: 'labrador',
        password_confirmation: 'labrador'
      )
    }

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


  end
end
