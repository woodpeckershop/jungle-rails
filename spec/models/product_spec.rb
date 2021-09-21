require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    # validation tests/examples here
    it 'should pass if all four fields are set' do
      @category = Category.new
      @product = Product.new(name:'pikachu', price:50, quantity:15, category:@category)
      expect(@product).to be_valid
      expect(@product.errors.full_messages).to_not be_present
    end

    it 'should not pass if the name field is nil' do
      @category = Category.new
      @product = Product.new(name:nil,price:50,quantity:15, category:@category )
      expect(@product).to_not be_valid
      expect(@product.errors.full_messages).to be_present
    end

    it 'should not pass if the price field is nil' do
      @category = Category.new
      @product = Product.new(name:'pikachu',price:nil,quantity:15, category:@category )
      expect(@product).to_not be_valid
      expect(@product.errors.full_messages).to be_present
    end

    it 'should not pass if the quantity field is nil' do
      @category = Category.new
      @product = Product.new(name:'pikachu',price:50,quantity:nil, category:@category )
      expect(@product).to_not be_valid
      expect(@product.errors.full_messages).to be_present
    end

    it 'should not pass if the category field is nil' do
      @category = Category.new()
      @product = Product.new(name:'auto-clicked mouse',price:50,quantity:15, category:nil )
      expect(@product).to_not be_valid
      expect(@product.errors.full_messages).to be_present
    end
  end
end
