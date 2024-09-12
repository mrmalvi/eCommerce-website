class Product < ApplicationRecord
  searchkick
  validates :title, :description, :price, :colors, :sizes, presence: true

  has_many_attached :images
  belongs_to :category

  serialize :colors, Array
  serialize :sizes, Array

  # settings do
  #   mappings dynamic: false do
  #     indexes :title, type: :text
  #     indexes :description, type: :text
  #     indexes :colors, type: :keyword
  #     indexes :sizes, type: :keyword
  #     indexes :price, type: :float
  #   end
  # end

  # def as_indexed_json(options = {})
  #   as_json(only: [:title, :description, :price], methods: [:colors, :sizes])
  # end
end
