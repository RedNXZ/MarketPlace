class Product < ApplicationRecord
  belongs_to :category
  has_many :order_items
  has_many :orders, through: :order_items
  has_one_attached :image

  before_destroy :check_for_order_items  # вот здесь!

  private

  def check_for_order_items
    if order_items.exists?
      errors.add(:base, "Невозможно удалить продукт, так как он присутствует в заказах")
      throw :abort
    end
  end
end
