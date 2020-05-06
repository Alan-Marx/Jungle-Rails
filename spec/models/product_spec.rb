require 'rails_helper'

RSpec.describe Product, type: :model do
  
  describe "Validations" do

    subject {
      described_class.new(
        name: 'Flamethrower',
        price: 30000,
        quantity: 50,
        category: Category.new
      )
    }

    it "is valid when all fields are present" do
      expect(subject).to be_valid
      expect(subject.errors.full_messages).to eq([])
    end
    
    it "is not valid if name is not present" do
      subject.name = nil
      expect(subject).to_not be_valid
      expect(subject.errors.full_messages).to eq(["Name can't be blank"])
    end

    it "is not valid if price is not present" do
      subject.price_cents = nil
      expect(subject).to_not be_valid
      expect(subject.errors.full_messages).to eq(["Price cents is not a number", "Price is not a number", "Price can't be blank"])
    end

    it "is not valid if quantity is not present" do
      subject.quantity = nil
      expect(subject).to_not be_valid
      expect(subject.errors.full_messages).to eq(["Quantity can't be blank"])
    end

    it "is not valid if category is not present" do
      subject.category = nil
      expect(subject).to_not be_valid
      expect(subject.errors.full_messages).to eq(["Category can't be blank"])
    end

  end
end
