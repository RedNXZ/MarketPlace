class OrdersController < ApplicationController
  before_action :authenticate_user!
  def new
    cart = session[:cart] || {}

    if cart.empty?
      redirect_to root_path, alert: "Корзина пуста, оформлять нечего."
      return
    end

    @order = Order.new
  end

  def create
    cart = session[:cart] || {}
    @order = Order.new(order_params)
    @order.user = current_user if user_signed_in?

    if @order.save
      # Привязка продуктов к заказу
      cart.each do |product_id, quantity|
        @order.order_items.create(product_id: product_id, quantity: quantity)
      end

      session[:cart] = {}  # Очистить корзину

      redirect_to order_path(@order), notice: "Ваш заказ №#{@order.id} успешно оформлен!"
    else
      render :new, alert: "Ошибка при оформлении заказа"
    end
  end

  def index
    @orders = current_user.orders.order(created_at: :desc)
  end

  # Просмотр конкретного заказа
  def show
    @order = current_user.orders.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to orders_path, alert: "Заказ не найден"
  end

  private

  def order_params
    params.require(:order).permit(:name, :address, :phone)
  end
end