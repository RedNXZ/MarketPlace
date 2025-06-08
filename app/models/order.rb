class Order < ApplicationRecord
  belongs_to :user
  has_many :order_items, dependent: :destroy
  validates :name, :address, :phone, presence: true
  def total_price
    order_items.includes(:product).sum do |item|
      item.quantity * item.product.price
    end
  end
end