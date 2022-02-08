require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do

    it 'saves product succesfully' do
      @category = Category.create
      @category.name = 'some_category'
      @product = Product.create
      @product.name = 'some_product'
      @product.price_cents = 3344
      @product.quantity = 22
      @product.category = @category
      expect(@product).to be_valid
    end

    it 'validates name' do
      @category = Category.create
      @category.name = 'new_category'
      @product = Product.create
      @product.name = nil
      @product.price_cents = 500
      @product.quantity = 25
      expect(@product.errors.full_messages).to include("Name can't be blank")
    end

    it 'validates price' do
      @category = Category.create
      @category.name = 'new_category1'
      @product = Product.create
      @product.name = 'test_product1'
      @product.price_cents = nil
      @product.quantity = 25
      expect(@product.errors.full_messages).to include("Price can't be blank")    
    end

    it 'validates quatity' do
      @category = Category.create
      @category.name = 'new_category2'
      @product = Product.create
      @product.name = 'test_product2'
      @product.price = 55
      @product.quantity = nil
      expect(@product.errors.full_messages).to include("Quantity can't be blank")
    end

    it 'validates quatity' do
      @category = nil
      @product = Product.create
      @product.name = 'test_product3'
      @product.price = 55
      @product.quantity = 40
      @product.category = @category
      expect(@product.errors.full_messages).to include("Category can't be blank")
    end

    


  end
end
