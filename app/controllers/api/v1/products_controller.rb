class Api::V1::ProductsController < Api::V1::BaseController
  def create
    product = ProductCreator.new(product_params).create
    render json: { status: product.persisted? }
  end

  private

  def product_params
    params.permit(:name, :sku_id, :expire_date, :price, categories: [], tags: [], images: [:img_path])
  end
end
