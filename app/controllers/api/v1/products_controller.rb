class Api::V1::ProductsController < Api::V1::BaseController
  def create
    product = ProductCreator.new(product_params).create

    response = if product.errors.blank?
                 { status: 'success' }
               else
                 { status: 'error', messages: product.errors.full_messages.join('\n') }
               end
    render json: response
  end

  private

  def product_params
    params.permit(:name, :sku_id, :expire_date, :price, categories: [], tags: [], images: [:img_path])
  end
end
