class Order < ActiveRecord::Base

  belongs_to :user
  has_many :line_items

  monetize :total_cents, numericality: true

  validates :stripe_charge_id, presence: true
  validate :has_inventory_for_product

  after_save :adjust_product_quantity, on: :create

  private

  def has_inventory_for_product
    line_items.each do |l|
      (l.product.quantity - l.quantity) >= 0
    end
  end

  def adjust_product_quantity
    line_items.each do |lineItem|
      p = lineItem.product
      lq = lineItem.quantity

      # will add validitaion so you cannot produce a negative
      # product quantity later
      p.update(quantity: (p.quantity - lq))

    end
  end
end
