class CartController < ApplicationController
  before_action :authenticate_user!
  def show
    @cart = session[:cart] || {}
    product_ids = @cart.keys
    @products = Product.where(id: product_ids)
  end

  def add
    session[:cart] ||= {}
    product_id = params[:product_id].to_s
    session[:cart][product_id] = (session[:cart][product_id] || 0) + 1
    redirect_to cart_path, notice: "Товар добавлен в корзину"
  end

  def remove
    session[:cart] ||= {}
    product_id = params[:product_id].to_s
    session[:cart].delete(product_id)
    redirect_to cart_path, notice: "Товар удалён из корзины"
  end
end