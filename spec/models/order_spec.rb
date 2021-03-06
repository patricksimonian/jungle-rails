require 'rails_helper'

RSpec.describe Order, type: :model do
 describe 'After creation' do
    before :each do
      # Setup at least two products with different quantities, names, etc
      @product1 = Product.create!({
        name: 'Test',
        price: 1231,
        quantity: 4,
        category: Category.new(name: "cats")
        })
      @product2 = Product.create!({
        name: 'blest',
        price: 1231,
        quantity: 2,
        category: Category.new(name: "bats")
        })

      # Setup at least one product that will NOT be in the order
      @product3 = Product.create!({
        name: 'mess',
        price: 1231,
        quantity: 4,
        category: Category.new(name: "rats")
        })
    end
    # pending test 1
    it 'deducts quantity from products based on their line item quantities' do
      # TODO: Implement based on hints below
      # 1. initialize order with necessary fields (see orders_controllers, schema and model definition for what is required)
      @order = Order.new(email: 'test@test.com',
      total_cents: (@product1.price + @product2.price),
      stripe_charge_id: 999 # returned by stripe)
      )
      # 2. build line items on @order
      @order.line_items.new( product: @product1,
        quantity: 2,
        item_price: @product1.price,
        total_price: @product1.price * 2
        )
      @order.line_items.new( product: @product2,
        quantity: 2,
        item_price: @product2.price,
        total_price: @product2.price * 2
        )

      # 3. save! the order - ie raise an exception if it fails (not expected)
      @order.save!
      # 4. reload products to have their updated quantities
      @product1.reload
      @product2.reload
      # 5. use RSpec expect syntax to assert their new quantity values
      expect(@product1.quantity).to eql (@order.line_items.first.quantity)
    end
    # pending test 2
    it 'does not deduct quantity from products that are not in the order' do
      # TODO: Implement based on hints in previous test
      expect(@product3.quantity).to be @product3.quantity
    end

    it 'does not complete order if quantity desired of product is greater then product quantity' do
      @order = Order.new(email: 'test@test.com',
        total_cents: (@product1.price),
        stripe_charge_id: 999 # returned by stripe)
        )
        # 2. build line items on @order
        @order.line_items.new( product: @product1,
          quantity: 10,
          item_price: @product1.price,
          total_price: @product1.price * 2
          )


        # @product1.reload

        expect(@order.save).to be false
    end
  end
end
