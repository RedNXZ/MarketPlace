class ProductsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :require_admin!, only: [:new, :create, :edit, :update, :destroy]

  def index
    if params[:category_id]
      @category = Category.find(params[:category_id])
      @products = @category.products
    else
      @products = Product.all
    end
  end

  def show
    @product = Product.find(params[:id])
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to @product, notice: "Товар успешно создан"
    else
      render :new
    end
  end

  def edit
    @product = Product.find(params[:id])
  end

  def update
    @product = Product.find(params[:id])
    if @product.update(product_params)
      redirect_to @product, notice: "Товар успешно обновлен"
    else
      render :edit
    end
  end
  def destroy
    @product = Product.find(params[:id])
    if @product.destroy
      redirect_to products_path, flash: { delete_notice: "Продукт успешно удалён" }
    else
      redirect_to root_path, flash: { delete_alert: @product.errors.full_messages.to_sentence }
    end
  end


  private

  def require_admin!
    unless current_user&.admin?
      redirect_to root_path, alert: "Доступ запрещён. Только для администратора."
    end
  end

  def product_params
    params.require(:product).permit(:name, :description, :price, :category_id, :image)
  end
end
