class Category < ApplicationRecord
  has_many :products

  before_destroy :check_for_products

  private

  def check_for_products
    if products.exists?
      errors.add(:base, "Невозможно удалить категорию, так как в ней есть товары")
      throw :abort
    end
  end
end