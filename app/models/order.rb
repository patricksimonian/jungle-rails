class Order < ActiveRecord::Base

  belongs_to :user
  has_many :line_items

  monetize :total_cents, numericality: true

  validates :stripe_charge_id, presence: true
  validate :has_inventory_for_product

  after_save :adjust_product_quantity, on: :create

  private

  def has_inventory_for_product
    has_inventory = true
    line_items.each do |l|
      if (l.product.quantity - l.quantity) < 0
        errors.add(:order, " :We have #{l.product.quantity} quantity of #{l.product.name} (you asked for #{l.quantity}) therefore we cannot process your order")
      end
    end
    has_inventory
  end

  def adjust_product_quantity
    line_items.each do |lineItem|
      product = lineItem.product
      lq = lineItem.quantity

      # will add validitaion so you cannot produce a negative
      # product quantity later
      product.update(quantity: (product.quantity - lq))

    end
  end
end
