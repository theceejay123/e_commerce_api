class Photographer < ApplicationRecord
  validates :full_name, :description, presence: true
  has_many :products
end
