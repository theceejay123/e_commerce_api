class Province < ApplicationRecord
  validates :name, presence: true
  has_many :taxes
  has_many :customers
end
