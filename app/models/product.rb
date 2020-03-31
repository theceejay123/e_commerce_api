class Product < ApplicationRecord
  belongs_to :photographer
  belongs_to :category
end
