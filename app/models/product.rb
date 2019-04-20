class Product < ApplicationRecord
  has_many_attached :images
  acts_as_taggable_on :categories, :tags

  validate :expire_date_is_valid
  validates :sku_id, uniqueness: true, presence: true
  validates :price, :sku_id, numericality: true

  def expire_date_is_valid
    errors.add(:expire_date, 'must be a valid date') if expire_date.blank?
  end
end
