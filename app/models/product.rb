class Product < ApplicationRecord
  has_many_attached :images
  acts_as_taggable_on :categories, :tags
end
