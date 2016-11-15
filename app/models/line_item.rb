class LineItem < ActiveRecord::Base

  belongs_to :order
  belongs_to :product, :dependent => :delete

  monetize :item_price_cents, numericality: true
  monetize :total_price_cents, numericality: true

end
