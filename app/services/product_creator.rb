require 'open-uri'

class ProductCreator
  attr_reader :attrs, :product

  def initialize(attrs = {})
    @attrs = attrs
  end

  def create
    @product = Product.find_or_initialize_by(sku_id: attrs[:sku_id])
    product.update_attributes(args_without_images)
    update_images
    product
  end

  private

  def update_associations
    update_images
  end

  def update_tags_and_categories
    product.categories.destroy_all
    product.tags.destroy_all
    product.categories = (attrs[:categories] || []).map { |category| product.categories.new(name: category) }
    product.tags = (attrs[:tags] || []).map { |tag| product.tags.new(name: tag) }
    product.save
  end

  def update_images
    product.images.purge_later
    (attrs[:images] || []).each do |file_or_filepath|
      attachment = get_file(file_or_filepath[:img_path])
      product.images.attach(attachment) if attachment.present?
    end
  end

  def get_file(file_or_filepath)
    if file_or_filepath.instance_of? ActionDispatch::Http::UploadedFile
      file_or_filepath
    else
      file = open(file_or_filepath)
      extension = file.meta['content-type'].split('/').last
      { io: file, filename: "filename.#{extension}", content_type: file.meta['content-type'] }
    end
  rescue StandardError
    nil
  end

  def args_without_images
    attrs.except(:images, :categories, :tags).merge(category_list: attrs[:categories], tag_list: attrs[:tags])
  end
end
