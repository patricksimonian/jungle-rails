require 'rails_helper'

RSpec.describe Product, type: :model do

  describe 'Validations' do

    it 'Will save with all four validations present' do
      @category = Category.new
      @product = Product.new({
        name: 'Test',
        price: 1231,
        quantity: 1,
        category: @category
        })

      expect(@product.save).to be true
    end

    it "will fail if no name is present" do
      @category = Category.new
      @product = Product.new({
        price: 1231,
        quantity: 1,
        category: @category
        })
      expect(@product.save).to be false
    end

    it "will fail if no price is present" do
      @category = Category.new
      @product = Product.new({
        name: "Test",
        quantity: 1,
        category: @category
        })
      expect(@product.save).to be false
    end

    it "will fail if no quantity is present" do
      @category = Category.new
      @product = Product.new({
        name: "test",
        price: 1231,
        category: @category
        })
      expect(@product.save).to be false
    end

    it "will fail if no category is present" do
      @category = Category.new
      @product = Product.new({
        name: "test",
        price: 1231,
        quantity: 1
        })
      expect(@product.save).to be false
    end
  end


end



