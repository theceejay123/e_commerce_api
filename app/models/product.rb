class Product < ApplicationRecord
  validates :name, :description, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0.00, allow_blank: true }
  has_many :order_details, through: :details

  has_one_attached :prod_image

  belongs_to :photographer
  belongs_to :category
end
