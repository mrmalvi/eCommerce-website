class Product < ApplicationRecord
  searchkick
  validates :title, :description, :price, :colors, :sizes, presence: true

  has_many_attached :images
  belongs_to :category

  serialize :colors, Array
  serialize :sizes, Array
end
