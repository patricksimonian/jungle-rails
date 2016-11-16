class Product < ActiveRecord::Base
  has_many :reviews, :dependent => :delete_all
  has_many :line_items, :dependent => :destroy
  monetize :price_cents, numericality: true
  mount_uploader :image, ProductImageUploader

  belongs_to :category

  validates :name, presence: true
  validates :price, presence: true
  validates :quantity, presence: true, :numericality => { :greater_than_or_equal_to => 0 }
  validates :category, presence: true

end
