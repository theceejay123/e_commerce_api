class OrderDetail < ApplicationRecord
  validates :reference_number, :total, :historical_tax, presence: :true
  validates :historical_tax, :total, numericality: { greater_than_or_equal_to: 0.00, allow_blank: true }
  belongs_to :customer
end
