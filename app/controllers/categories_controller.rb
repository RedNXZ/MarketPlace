class CategoriesController < ApplicationController
  before_action :require_admin!, only: [:new, :create, :destroy, :delete]

  def index
    @categories = Category.all
  end

  def show
    @category = Category.find(params[:id])
    @products = @category.products
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      redirect_to root_path, notice: "Категория успешно создана"
    else
      render :new
    end
  end

  def delete
    @categories = Category.all
  end

  def destroy
    @category = Category.find(params[:id])
    if @category.destroy
      redirect_to delete_categories_path, notice: "Категория успешно удалена"
    else
      redirect_to delete_categories_path, alert: @category.errors.full_messages.to_sentence
    end
  end

  private

  def require_admin!
    unless current_user&.admin?
      redirect_to root_path, alert: "Доступ запрещён. Только для администратора."
    end
  end

  def category_params
    params.require(:category).permit(:name)
  end
end
