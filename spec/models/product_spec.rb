require 'rails_helper'

RSpec.describe Product, type: :model do
  describe "validations" do
    before(:each) do
      @category = Category.new(name: "trees")
    end

    it 'validates there is a product' do
      @product = Product.new(name: "birch", price_cents: 10000, quantity: 5, category: @category)
      expect(@product).to be_present
      expect(@category).to be_present
    end

    it 'shows error when no name is set' do
      @product = Product.new(name: nil, price_cents: 10, quantity: 5, category: @category)
      @product.save

      expect(@product.errors.full_messages).to include("Name can't be blank")
    end

    it 'shows error when no price is set' do
      @product = Product.new(name: "name", price_cents: nil, quantity: 5, category: @category)
      @product.save

      expect(@product.errors.full_messages).to include("Price is not a number")
    end

    it 'shows error when no quantity is set' do
      @product = Product.new(name: "name", price_cents: 10000, quantity: nil, category: @category)
      @product.save

      expect(@product.errors.full_messages).to include("Quantity can't be blank")
    end

    it 'shows error when no category is selected' do
      @product = Product.new(name: "name", price_cents: 10000, quantity: 5, category: nil)
      @product.save
      
      expect(@product.errors.full_messages).to include("Category can't be blank")
    end
      
  end
end
