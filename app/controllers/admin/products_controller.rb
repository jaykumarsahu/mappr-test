class Admin::ProductsController < ApplicationController
  before_action :set_product, only: %i[edit update]

  def index
    @products = Product.all
  end

  def edit; end

  def update
    respond_to do |format|
      if @product.update_attributes(product_params)
        format.html { redirect_to admin_products_path, notice: 'Product was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  private

  def set_product
    @product = Product.find_by_id(params[:id])
  end

  def product_params
    params.require(:product).permit(:name, :sku_id, :expire_date, :price, :tag_list, :category_list)
  end
end
