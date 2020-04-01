class Size < ApplicationRecord
  validates :name, :size, presence: true
  has_and_belongs_to_many :products
end
